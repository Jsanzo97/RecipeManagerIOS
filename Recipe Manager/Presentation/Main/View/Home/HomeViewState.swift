//
//  HomeViewState.swift
//  Recipe Manager
//


import Foundation

/**
 HomeViewState
 
 List of possible view states for the home screen
 */
enum HomeViewState {
    case displayRecipes(recipes: [Recipe])
    case loading
    case removedRecipe
    case error(title: String, message: String)
}

extension HomeViewState : Equatable {
    static func == (lhs: HomeViewState, rhs: HomeViewState) -> Bool {
        switch (lhs, rhs) {
        case (.displayRecipes, .displayRecipes): return true
        case (.loading, .loading): return true
        case (.removedRecipe, .removedRecipe): return true
        case (.error(let title, let message), .error(let title2, let message2)):
            return (title == title2 && message == message2) ? true : false
        default:
            return false
        }
    }
}
