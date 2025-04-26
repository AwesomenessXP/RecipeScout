//
//  RecipeRepositoryError.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

enum RecipeRepositoryError: Error {
    case failedToFetchRecipes(Error)
    
    var stringDescription: String {
        switch self {
        case .failedToFetchRecipes(let error):
            return "Failed to fetch recipes: \(error.localizedDescription)"
        }
    }
}
