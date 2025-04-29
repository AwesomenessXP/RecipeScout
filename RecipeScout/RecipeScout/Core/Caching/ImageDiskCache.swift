//
//  DiskCache.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/27/25.
//

import SwiftUI
import CryptoKit

actor ImageDiskCache: ImageCacheProtocol {
    
    // absolute path to Documents in swift
    let imagesDirectory: URL
    
    init(folder: String) {
        let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        self.imagesDirectory = documentsURL.appendingPathComponent(folder, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: imagesDirectory.path) {
            try? FileManager.default.createDirectory(at: imagesDirectory, withIntermediateDirectories: true, attributes: nil)
        }
    }
    
    public func write(data: Data, url: URL) async throws {
        do {
            let imagePath = getImagePath(for: url)
            try data.write(to: imagePath)
            print("wrote to disk")
            
        } catch let error {
            throw ImageCacheError.unableToWrite(error)
        }
    }
    
    public func read(url: URL) async throws -> UIImage? {
        do {
            let imagePath = getImagePath(for: url)
            let data = try Data(contentsOf: imagePath)
            if let image = UIImage(data: data) {
                print("read from disk")
                return image
            }
            
            return nil
            
        } catch {
            return nil
        }
    }
    
    private func hashURL(for url: URL) -> String {
        let relativeImagePath = url.absoluteString
        let hashed = SHA256.hash(data: relativeImagePath.data(using: .utf8) ?? Data())
        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()
        
        return hashString
    }
    
    private func getImagePath(for url: URL) -> URL {
        let hashedURL = hashURL(for: url)
        let imagePath = imagesDirectory
            .appendingPathComponent(hashedURL, isDirectory: false)
        
//        print("image path: \(imagePath)")
        
        return imagePath
    }
}
