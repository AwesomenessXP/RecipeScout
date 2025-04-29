//
//  CoreNetworkClient.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import XCTest
@testable import RecipeScout

class MockNetworkClient: NetworkClientProtocol {
    var mockData: Data?
    var mockError: NetworkError?
    var isBadURL: Bool = false
    
    func fetch(from url: URL?) async throws -> Data {
        if let error = mockError {
            throw error
        }
        if let data = mockData {
            return data
        }
        throw NetworkError.invalidURL
    }
}
