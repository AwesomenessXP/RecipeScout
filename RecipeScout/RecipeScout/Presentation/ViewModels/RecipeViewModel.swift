//
//  RecipeViewModel.swift
//  RecipeScout
//
//  Created by Haskell Macaraig on 4/26/25.
//
import Foundation

class RecipeViewModel: ObservableObject {
    @Published var recipes: [RecipeEntity] = []
    @Published var errorMessage: String = ""
    @Published var showError = false
    let fetchRecipesUseCase: FetchRecipesUseCase
    
    init(fetchRecipesUseCase: FetchRecipesUseCase) {
        self.fetchRecipesUseCase = fetchRecipesUseCase
    }
    
    @MainActor
    func fetchRecipes() async {
        do {
            let recipes = try await fetchRecipesUseCase.execute()
            await MainActor.run {
                self.recipes = recipes
            }
            print("fetched recipes!")
        } catch let error as FetchRecipesError {
            switch error {
            case .emptyData:
                self.recipes = []
            case .malformedData:
                self.errorMessage = "Malformed Data"
                showError = true
            case .networkError:
                self.errorMessage = "Network Error"
                showError = true
            }
        } catch let error {
            self.errorMessage = "\(error)"
            showError = true
        }
    }
}
