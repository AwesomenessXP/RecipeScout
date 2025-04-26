//
//  NetworkError.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

enum APIError: Error {
    case invalidURL
    case invalidStatusCode(Int)
    case networkError(Error)
    
    var stringDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .invalidStatusCode(let code):
            return "Invalid status code: \(code)"
        case .networkError(let error):
            return "Network error: \(error.localizedDescription)"
        }
    }
}
