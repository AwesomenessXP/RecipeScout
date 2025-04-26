//
//  NetworkClientProtocol.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import Foundation

protocol NetworkClientProtocol {
    func fetch(from url: URL?) async throws -> Data
}
