//
//  RecipeRepository.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import Foundation

protocol RecipeRepositoryProtocol {
    func fetchRecipes(from url: URL?) async throws -> [RecipeEntity]
}

class RecipeRepository: RecipeRepositoryProtocol {
    let networkClient: NetworkClientProtocol
    
    init(networkClient: NetworkClientProtocol) {
        self.networkClient = networkClient
    }
    
    public func fetchRecipes(from url: URL?) async throws -> [RecipeEntity] {
        do {
            let recipes = try await self.networkClient.fetch(from: url)
            let decodedRecipes = try JSONDecoder().decode(RecipesDTO.self, from: recipes)
            let recipeDTOs: [RecipeDTO] = decodedRecipes.recipes
            let mappedRecipes: [Recipe] = try self.mapToRecipes(recipeDTOs: recipeDTOs)
            let mappedRecipeEntities: [RecipeEntity] = self.mapToRecipeEntities(recipes: mappedRecipes)
            
            return mappedRecipeEntities
            
        } catch let error as DecodeRecipeError {
            throw RecipeRepositoryError.failedToDecodeRecipes(error)
            
        } catch let error as DecodingError {
            throw RecipeRepositoryError.failedToDecodeRecipes(DecodeRecipeError.malformedData)
            
        } catch let error as NetworkError {
            throw RecipeRepositoryError.networkError(error)
            
        }
    }
    
    private func mapToRecipes(recipeDTOs: [RecipeDTO]) throws -> [Recipe] {
        guard !recipeDTOs.isEmpty else {
            throw RecipeRepositoryError.failedToDecodeRecipes(DecodeRecipeError.emptyData)
        }
        
        let recipes: [Recipe] = recipeDTOs.compactMap { recipeDTO in
            guard !recipeDTO.cuisine.isEmpty,
                  !recipeDTO.name.isEmpty,
                  let uuid = UUID(uuidString: recipeDTO.uuid)
            else {
                return nil
            }
            
            let recipe = Recipe(
                id: uuid,
                cuisine: recipeDTO.cuisine,
                name: recipeDTO.name,
                photo_url_large: URL(string: recipeDTO.photo_url_large ?? ""),
                photo_url_small: URL(string: recipeDTO.photo_url_small ?? ""),
                source_url: URL(string: recipeDTO.source_url ?? ""),
                youtube_url: URL(string: recipeDTO.youtube_url ?? "")
            )
            
            return recipe
        }
        
        if recipes.count < recipeDTOs.count {
            throw RecipeRepositoryError.failedToDecodeRecipes(DecodeRecipeError.malformedData)
        }
        
        return recipes
    }
    
    private func mapToRecipeEntities(recipes: [Recipe]) -> [RecipeEntity] {
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
