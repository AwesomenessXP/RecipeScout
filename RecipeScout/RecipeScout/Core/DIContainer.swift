//
//  DIContainer.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

final class DIContainer {
    let networkClient: NetworkClientProtocol
    let recipeRepository: RecipeRepositoryProtocol
    let fetchRecipesUseCase: FetchRecipesUseCase
    
    init() {
        networkClient = CoreNetworkClient()
        recipeRepository = RecipeRepository(networkClient: networkClient)
        fetchRecipesUseCase = FetchRecipesUseCase(repository: recipeRepository)
    }
    
    public func createRecipeViewModel() -> RecipeViewModel {
        return RecipeViewModel(fetchRecipesUseCase: fetchRecipesUseCase)
    }
}
