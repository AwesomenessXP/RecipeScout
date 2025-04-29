//
//  ContentView.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//

import SwiftUI

struct RecipeListsView: View {
    @StateObject var viewModel: RecipeViewModel
    @State private var images: [URL: UIImage] = [:]
    let imageLoader: ImageLoader
    @State private var isLoading: Bool = false
    @State private var isFetched: Bool = false
    
    var body: some View {
        ScrollView {
            if isLoading {
                ProgressView("Loading...")
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if isFetched && viewModel.recipes.isEmpty {
                Text("No recipes found.")
            } else {
                VStack(alignment: .leading, spacing: 8) {
                    ForEach(viewModel.recipes) { recipe in
                        RecipeCellView(recipe: recipe, images: $images, imageLoader: imageLoader)
                    }
                }
            }
        }
        .onAppear {
            fetchRecipes()
        }
        .refreshable {
            fetchRecipes()
        }
        .alert(isPresented: $viewModel.showError) {
            Alert(
                title: Text("Error"),
                message: Text(viewModel.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func fetchRecipes() {
        Task(priority: .high) {
            isLoading = true
            await viewModel.fetchRecipes()
            
            print("recipes count: \(viewModel.recipes.count)")
            
            for recipe in viewModel.recipes {
                guard let url = recipe.photo_url_small else { return }

                if images[url] != nil {
                    return
                }
                
                Task(priority: .userInitiated) {
                    guard let url = recipe.photo_url_small else { return }
                    
                    do {
                        let image = try await self.imageLoader.load(url: url)
                        if let url = recipe.photo_url_small {
                            await MainActor.run {
                                images[url] = image
                            }
                        }
                        
                    } catch {
                        print("error: \(error), url: \(url)")
                        print("error loading image: \(error.localizedDescription)")
                    }
                }
            }
            isFetched = true
            isLoading = false
        }
    }
}

struct RecipeCellView: View {
    let recipe: RecipeEntity
    @Binding var images: [URL: UIImage]
    let imageLoader: ImageLoader
    @State private var task: Task<Void, Never>?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text(recipe.name)
                        .font(.subheadline)
                    Text(recipe.cuisine)
                        .font(.caption)
                }
                Spacer()
                
                if let url = recipe.photo_url_small, let image = images[url] {
                    Image(uiImage: image)
                    
                } else {
                    Color.gray.opacity(0.8)
                        .frame(width: 80, height: 80)
                }
            }
            Divider()
        }
        .padding()
    }
}

//#Preview {
//    RecipeListsView()
//}
