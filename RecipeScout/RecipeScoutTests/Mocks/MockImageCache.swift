//
//  MockImageCache.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/27/25.
//
import XCTest
@testable import RecipeScout

class MockImageCache: ImageCacheProtocol {
    
    var inMemoryCache: [URL: UIImage] = [:]
    
    func write(data: Data, url: URL) async throws {
        inMemoryCache[url] = UIImage(data: data)
    }
    
    func read(url: URL) async throws -> UIImage? {
        return inMemoryCache[url]
    }
}
