//
//  ContentView.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import SwiftUI

struct RecipeListsView: View {
    @StateObject var viewModel: RecipeViewModel
    
    var body: some View {
        Text("hello world")
            .onAppear {
                Task {
                    try await viewModel.fetchRecipes()
                }
            }
    }
}

//#Preview {
//    RecipeListsView()
//}
