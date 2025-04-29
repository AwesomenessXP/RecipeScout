//
//  ImageCacheTests.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/27/25.
//

import XCTest
import UIKit
import CryptoKit
@testable import RecipeScout

final class ImageCacheTests: XCTestCase {
    
    var mockNetworkClient: MockNetworkClient!
    var imageCache: ImageDiskCache!
    var imageLoader: ImageLoader!

    override func setUpWithError() throws {
        mockNetworkClient = MockNetworkClient()
        imageCache = ImageDiskCache(folder: "ImagesTest")
        imageLoader = ImageLoader(diskCache: imageCache, networkClient: mockNetworkClient)
    }

    override func tearDownWithError() throws {
        mockNetworkClient = nil
        imageCache = nil
        imageLoader = nil
    }

    func testCorrectCaching() async throws {
        let writeExpectation = expectation(description: "write")
        let readExpectation = expectation(description: "read")
        
        let image = UIImage(named: "square1")!
        
        try await imageCache.write(data: image.jpegData(compressionQuality: 1)!, url: URL(string: "https://example.com/image")!)
        writeExpectation.fulfill()
        await fulfillment(of: [writeExpectation], timeout: 2)
        
        let cachedImage = try await imageCache.read(url: URL(string: "https://example.com/image")!)
        readExpectation.fulfill()
        await fulfillment(of: [readExpectation], timeout: 2)
        
        XCTAssertNotNil(cachedImage)
    }
    
    func testCorrectImageLoading() async throws {
        let loadExpectation = expectation(description: "load")
        
        let url = URL(string: "https://example.com/image")!
        let image = try await imageLoader.load(url: url)
        loadExpectation.fulfill()
        await fulfillment(of: [loadExpectation], timeout: 2)
        
        XCTAssertNotNil(image)
    }
}
