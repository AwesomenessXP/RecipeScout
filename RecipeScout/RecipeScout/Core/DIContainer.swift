//
//  DIContainer.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

final class DIContainer {
    let networkClient: NetworkClientProtocol
    let recipeRepository: RecipeRepositoryProtocol
    let fetchRecipesUseCase: FetchRecipesUseCase
    let imageCache: ImageCacheProtocol
    let imageLoader: ImageLoader
    
    init() {
        networkClient = NetworkClient()
        recipeRepository = RecipeRepository(networkClient: networkClient)
        fetchRecipesUseCase = FetchRecipesUseCase(repository: recipeRepository)
        imageCache = ImageDiskCache(folder: "Images")
        imageLoader = ImageLoader(diskCache: imageCache, networkClient: networkClient)
    }
    
    public func createRecipeViewModel() -> RecipeViewModel {
        return RecipeViewModel(fetchRecipesUseCase: fetchRecipesUseCase)
    }
}
