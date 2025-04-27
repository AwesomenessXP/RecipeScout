//
//  RecipeRepositoryError.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

enum RecipeRepositoryError: Error, Equatable {
    static func == (lhs: RecipeRepositoryError, rhs: RecipeRepositoryError) -> Bool {
        switch (lhs, rhs) {
        case (.failedToDecodeRecipes(let error1), .failedToDecodeRecipes(let error2)):
            return error1 == error2
        case (.networkError(let error1), .networkError(let error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
    
    
    case failedToDecodeRecipes(DecodeRecipeError)
    case networkError(NetworkError)
    
    var stringDescription: String {
        switch self {
        case .failedToDecodeRecipes(let error):
            return "Failed to fetch recipes: \(error.localizedDescription)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
