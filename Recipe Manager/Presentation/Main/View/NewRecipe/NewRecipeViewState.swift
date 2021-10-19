//
//  NewRecipeViewState.swift
//  Recipe Manager
//


import Foundation

/**
 NewRecipeViewState
 
 List of possible view states for the new recipe screen
 */
enum NewRecipeViewState {
    case loading
    case dataReady(difficultTypes: [Difficult], ingredientTypes: [IngredientType], categoryTypes: [Category], subcategoryTypes: [Subcategory])
    case createdNewRecipe
    case error(title: String, message: String)
}

extension NewRecipeViewState : Equatable {
    static func == (lhs: NewRecipeViewState, rhs: NewRecipeViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.dataReady(let difficultTypes, let ingredientTypes, let categoryTypes, let subcategoryTypes), .dataReady(let difficultTypes2, let ingredientTypes2, let categoryTypes2, let subcategoryTypes2)): return (difficultTypes == difficultTypes2 && ingredientTypes == ingredientTypes2 && categoryTypes == categoryTypes2 && subcategoryTypes == subcategoryTypes2)
        case (.createdNewRecipe, .createdNewRecipe): return true
        case (.error(let title, let message), .error(let title2, let message2)):
            return (title == title2 && message == message2) ? true : false
        default:
            return false
        }
    }
}
