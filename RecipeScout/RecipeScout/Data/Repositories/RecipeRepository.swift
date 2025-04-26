//
//  RecipeRepository.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchRecipes() async throws -> [RecipeEntity]
}

class RecipeRepository: RecipeRepositoryProtocol {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    public func fetchRecipes() async throws -> [RecipeEntity] {
        let url = URL(string: "https://d3jbb8n5wk0qxi.cloudfront.net/recipes.json")
        guard let url else {
            throw APIError.invalidURL
        }
        let recipes = try await self.networkClient.fetch(from: url)
        let decodedRecipes = try JSONDecoder().decode(RecipesDTO.self, from: recipes)
        let recipeDTOs = decodedRecipes.recipes
        let mappedRecipes: [Recipe] = try self.mapToRecipes(recipeDTOs: decodedRecipes)
        let mappedRecipeEntities: [RecipeEntity] = self.mapToRecipeEntities(recipes: mappedRecipes)
        
        return mappedRecipeEntities
    }
    
    public func mapToRecipes(recipeDTOs: RecipesDTO) throws -> [Recipe] {
        guard !recipeDTOs.recipes.isEmpty else {
            throw DecodingError.emptyData
        }
        
        let recipes: [Recipe] = recipeDTOs.recipes.compactMap { recipeDTO in
            guard !recipeDTO.cuisine.isEmpty,
                  !recipeDTO.name.isEmpty,
                  let uuid = UUID(uuidString: recipeDTO.uuid),
                  let photo_url_large = URL(string: recipeDTO.photo_url_large ?? ""),
                  let photo_url_small = URL(string: recipeDTO.photo_url_small ?? ""),
                  let source_url = URL(string: recipeDTO.source_url ?? ""),
                  let youtube_url = URL(string: recipeDTO.youtube_url ?? "")
            else {
                return nil
            }
            
            return Recipe(
                id: uuid,
                cuisine: recipeDTO.cuisine,
                name: recipeDTO.name,
                photo_url_large: photo_url_large,
                photo_url_small: photo_url_small,
                source_url: source_url,
                youtube_url: youtube_url
            )
        }
        
        if recipes.count < recipeDTOs.recipes.count {
            throw DecodingError.malformedData
        }
        
        return recipes
    }
    
    public func mapToRecipeEntities(recipes: [Recipe]) -> [RecipeEntity] {
        return recipes.map {
            RecipeEntity(
                id: $0.id,
                cuisine: $0.cuisine,
                name: $0.name,
                photo_url_large: $0.photo_url_large,
                photo_url_small: $0.photo_url_small,
                source_url: $0.source_url,
                youtube_url: $0.youtube_url
            )
        }
    }
}
