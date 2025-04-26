//
//  NetworkClient.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

class CoreNetworkClient: NetworkClientProtocol {
    func fetch(from url: URL) async throws -> Data {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.invalidStatusCode(-1)
        }

        guard (200...299).contains(httpResponse.statusCode) else {
            throw APIError.invalidStatusCode(httpResponse.statusCode)
        }
        
        return data
    }
}
