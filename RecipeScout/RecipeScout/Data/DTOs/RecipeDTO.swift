//
//  RecipeDTO.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

struct RecipeDTO: Decodable {
    var cuisine: String
    var name: String
    var photo_url_large: String?
    var photo_url_small: String?
    var uuid: String
    var source_url: String?
    var youtube_url: String?
}
