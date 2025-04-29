//
//  RecipeScoutApp.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import SwiftUI

@main
struct RecipeScoutApp: App {
    let diContainer = DIContainer()
    
    var body: some Scene {
        WindowGroup {
            RecipeListsView(viewModel: diContainer.createRecipeViewModel(), imageLoader: diContainer.imageLoader)
        }
    }
}
