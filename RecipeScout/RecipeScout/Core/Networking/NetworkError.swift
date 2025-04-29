//
//  NetworkError.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

enum NetworkError: Error, Equatable {
    static func == (lhs: NetworkError, rhs: NetworkError) -> Bool {
        switch (lhs, rhs) {
        case (.invalidURL, .invalidURL):
            return true
        case (.invalidStatusCode(let code1), .invalidStatusCode(let code2)):
            return code1 == code2
        case (.networkError(let error1), .networkError(let error2)):
            return error1.localizedDescription == error2.localizedDescription
        default:
            return false
        }
    }
    
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
            return "Network error: \(error)"
        }
    }
}
