//
//  NetworkTests.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import XCTest
@testable import RecipeScout

final class RecipeRepositoryTests: XCTestCase {
    
    var recipeRepository: RecipeRepository!
    var networkClient: MockNetworkClient!

    override func setUpWithError() throws {
        networkClient = MockNetworkClient()
        recipeRepository = RecipeRepository(networkClient: networkClient)
    }

    override func tearDownWithError() throws {
        networkClient = nil
        recipeRepository = nil
    }

    func testProperFetch() async throws {
        let mockString = """
        {
            "recipes": [
                {
                    "cuisine": "Malaysian",
                    "name": "Apam Balik",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/b9ab0071-b281-4bee-b361-ec340d405320/small.jpg",
                    "source_url": "https://www.nyonyacooking.com/recipes/apam-balik~SJ5WuvsDf9WQ",
                    "uuid": "0c6ca6e7-e32a-4053-b824-1dbf749910d8",
                    "youtube_url": "https://www.youtube.com/watch?v=6R8ffRRJcrg"
                },
                {
                    "cuisine": "British",
                    "name": "Apple & Blackberry Crumble",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/535dfe4e-5d61-4db6-ba8f-7a27b1214f5d/small.jpg",
                    "source_url": "https://www.bbcgoodfood.com/recipes/778642/apple-and-blackberry-crumble",
                    "uuid": "599344f4-3c5c-4cca-b914-2210e3b3312f",
                    "youtube_url": "https://www.youtube.com/watch?v=4vhcOwVBDO4"
                },
                {
                    "cuisine": "British",
                    "name": "Apple Frangipan Tart",
                    "photo_url_large": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/large.jpg",
                    "photo_url_small": "https://d3jbb8n5wk0qxi.cloudfront.net/photos/7276e9f9-02a2-47a0-8d70-d91bdb149e9e/small.jpg",
                    "uuid": "74f6d4eb-da50-4901-94d1-deae2d8af1d1",
                    "youtube_url": "https://www.youtube.com/watch?v=rp8Slv4INLk"
                },
            ]
        }
        """
        
        networkClient.mockData = mockString.data(using: .utf8)!
        let fetchExpectation = expectation(description: "Fetch expectation")
        
        let recipes = try await recipeRepository.fetchRecipes()
        fetchExpectation.fulfill()
        await fulfillment(of: [fetchExpectation], timeout: 2)
        
        XCTAssert(recipes.count == 3)
    }
    
    func testFetchError() async throws {
        networkClient.mockError = NetworkError.invalidStatusCode(404)
        
        do {
            _ = try await recipeRepository.fetchRecipes()

            XCTFail("Expected fetchRecipes to throw, but it succeeded.")
            
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidStatusCode(404))
            
        } catch {
            XCTFail("Expected NetworkError, but got different error: \(error)")
        }
    }
    
    func testBadURL() async throws {
        networkClient.isBadURL = true
        
        do {
            _ = try await recipeRepository.fetchRecipes()

            XCTFail("Expected fetchRecipes to throw, but it succeeded.")
            
        } catch let error as NetworkError {
            XCTAssertEqual(error, NetworkError.invalidURL)
            
        } catch {
            XCTFail("Expected NetworkError, but got different error: \(error)")
        }
    }
}
