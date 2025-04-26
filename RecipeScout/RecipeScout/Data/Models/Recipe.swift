//
//  Recipe.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import Foundation

struct Recipe: Identifiable {
    let id: UUID
    let cuisine: String
    let name: String
    let photo_url_large: URL?
    let photo_url_small: URL?
    let source_url: URL?
    let youtube_url: URL?
}
