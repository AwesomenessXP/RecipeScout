//
//  ImageLoader.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/27/25.
//
import SwiftUI

class ImageLoader {
    let diskCache: ImageCacheProtocol
    let networkClient: NetworkClientProtocol
    
    init(diskCache: ImageCacheProtocol, networkClient: NetworkClientProtocol) {
        self.diskCache = diskCache
        self.networkClient = networkClient
    }
    
    public func load(url: URL) async throws -> UIImage? {
        
        do {
            // check disk first
            let cachedImage = try await diskCache.read(url: url)
            
            // on cache hit, return image
            guard cachedImage == nil else {
                return cachedImage
            }
            
            // on cache miss, download image
            let data = try await networkClient.fetch(from: url)
            guard let downloadedImage = UIImage(data: data) else {
                return nil
            }
            
            try await diskCache.write(data: data, url: url)
            
            return downloadedImage
            
        } catch let error as ImageCacheError {
            throw error
        } catch let error as NetworkError {
            throw error
        }
    }
}
