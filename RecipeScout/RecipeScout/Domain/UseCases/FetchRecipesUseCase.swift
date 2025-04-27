//
//  FetchRecipesUseCase.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

class FetchRecipesUseCase {
    let repository: RecipeRepositoryProtocol
    
    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [RecipeEntity] {
        do {
            let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
            return try await repository.fetchRecipes(from: url)
        } catch (let error as RecipeRepositoryError) {
            throw FetchRecipesError.failedToFetchRecipes(error)
        }
    }
}
