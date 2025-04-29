//
//  FetchRecipesError.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

enum FetchRecipesError: Error, Equatable {
    case emptyData
    case malformedData
    case networkError(NetworkError)
    
    var stringDescription: String {
        switch self {
        case .emptyData:
            return "Empty data returned from the server."
        case .malformedData:
            return "Malformed data returned from the server."
        case .networkError(let error):
            return "Network error: \(error)"
        }
    }
}
