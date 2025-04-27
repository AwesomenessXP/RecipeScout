//
//  MockRecipeRepository.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import XCTest
@testable import RecipeScout

class MockRecipeRepository: RecipeRepositoryProtocol {
    let networkClient: NetworkClientProtocol
    var error: RecipeRepositoryError?
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    public func fetchRecipes(from url: URL?) async throws -> [RecipeEntity] {
        guard let _ = url else {
            throw RecipeRepositoryError.networkError(NetworkError.invalidURL)
        }
        
        if let error {
            throw error
        }
        
        let recipeEntities = [
            RecipeEntity(id: UUID(), cuisine: "Thai", name: "Pad Thai", photo_url_large: nil, photo_url_small: nil, source_url: nil, youtube_url: nil),
            RecipeEntity(id: UUID(), cuisine: "Italian", name: "Spaghetti Carbonara", photo_url_large: nil, photo_url_small: nil, source_url: nil, youtube_url: nil),
            RecipeEntity(id: UUID(), cuisine: "French", name: "Coq au Vin", photo_url_large: nil, photo_url_small: nil, source_url: nil, youtube_url: nil)
        ]
        return recipeEntities
    }
}

