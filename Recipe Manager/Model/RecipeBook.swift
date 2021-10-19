//
//  RecipeBook.swift
//  Recipe Manager
//


import Foundation

/**
 RecipeBook
 
 Entity representing the recipe  book
 */
public struct RecipeBook: Encodable {
    
    var recipes: [Recipe]
    
    
    init(recipes: [Recipe]) {
        self.recipes = recipes
    }
}

extension RecipeBook : Equatable {
    public static func == (lhs: RecipeBook, rhs: RecipeBook) -> Bool {
        return (lhs.recipes == rhs.recipes) ? true : false
    }
}
