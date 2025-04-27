//
//  DecodingError.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import Foundation

enum DecodeRecipeError: Error {
    case malformedData
    case emptyData
    
    var stringDescription: String {
        switch self {
        case .malformedData:
            return "Malformed data"
        case .emptyData: 
            return "Empty data"
        }
    }
}
