//
//  FetchRecipesTests.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import XCTest
@testable import RecipeScout

final class FetchRecipesTests: XCTestCase {
    
    var mockRecipeRepository: MockRecipeRepository!
    var mockNetworkClient: MockNetworkClient!
    var fetchRecipes: FetchRecipesUseCase!

    override func setUpWithError() throws {
        mockNetworkClient = MockNetworkClient()
        mockRecipeRepository = MockRecipeRepository(networkClient: mockNetworkClient)
        fetchRecipes = FetchRecipesUseCase(repository: mockRecipeRepository)
    }

    override func tearDownWithError() throws {
        mockNetworkClient = nil
        mockRecipeRepository = nil
        fetchRecipes = nil
    }

    func testProperFetch() async throws {
        let fetchExpectation = expectation(description: "Fetch expectation")
        
        let recipes = try await fetchRecipes.execute()
        fetchExpectation.fulfill()
        await fulfillment(of: [fetchExpectation], timeout: 2)
        
        XCTAssert(recipes.count == 3)
    }
    
    func testMalformedFetch() async throws {
        let decodingError = RecipeRepositoryError.failedToDecodeRecipes(DecodeRecipeError.malformedData)
        mockRecipeRepository.error = decodingError
        
        do {
            _ = try await fetchRecipes.execute()

            XCTFail("Expected fetchRecipes to throw, but it succeeded.")
            
        } catch let error as FetchRecipesError {
            XCTAssertEqual(FetchRecipesError.malformedData, error)
            
        } catch {
            XCTFail("Expected RecipeRepositoryError, but got different error: \(error)")
        }
    }
    
    func testEmptyFetch() async throws {
        let decodingError = RecipeRepositoryError.failedToDecodeRecipes(DecodeRecipeError.emptyData)
        mockRecipeRepository.error = decodingError
        
        do {
            _ = try await fetchRecipes.execute()

            XCTFail("Expected fetchRecipes to throw, but it succeeded.")
            
        } catch let error as FetchRecipesError {
            XCTAssertEqual(FetchRecipesError.emptyData, error)
            
        } catch {
            XCTFail("Expected RecipeRepositoryError, but got different error: \(error)")
        }
    }
}
