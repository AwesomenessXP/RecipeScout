//
//  FetchRecipesUseCase.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

class FetchRecipesUseCase {
    let repository: RecipeRepositoryProtocol
    
    init(repository: RecipeRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() async throws -> [RecipeEntity] {
        do {
            return try await repository.fetchRecipes()
        } catch (let error) {
            throw RecipeRepositoryError.failedToFetchRecipes(error)
        }
    }
}
