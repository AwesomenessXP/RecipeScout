//
//  NetworkClient.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

class NetworkClient: NetworkClientProtocol {
    func fetch(from url: URL?) async throws -> Data {
        guard let url else {
            throw NetworkError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            guard let httpResponse = response as? HTTPURLResponse else {
                print("invalid status code: \(-1)")
                throw NetworkError.invalidStatusCode(-1)
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                print("invalid status code: \(httpResponse.statusCode)")
                throw NetworkError.invalidStatusCode(httpResponse.statusCode)
            }
            
            return data
        } catch let error as URLError {
            throw NetworkError.networkError(error)
        }
    }
}
