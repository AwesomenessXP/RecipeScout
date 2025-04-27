//
//  RecipeViewModel.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

class RecipeViewModel: ObservableObject {
    let fetchRecipesUseCase: FetchRecipesUseCase
    
    init(fetchRecipesUseCase: FetchRecipesUseCase) {
        self.fetchRecipesUseCase = fetchRecipesUseCase
    }
    
    func fetchRecipes() async throws {
        let recipes = try await fetchRecipesUseCase.execute()
        print(recipes)
    }
}
