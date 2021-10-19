//
//  Recipe.swift
//  Recipe Manager
//


import Foundation

/**
 Recipe
 
 Entity representing the recipe
 */
public struct Recipe: Encodable {
    
    var name: String
    var description: String
    var duration: Double
    var difficult: String
    var ingredients: [Ingredient]
    var category: String
    var subcategories: [Subcategory]
    
    init(name: String, description: String, duration: Double, difficult: String, ingredients: [Ingredient], category: String, subcategories: [Subcategory]) {
        self.name = name
        self.description = description
        self.duration = duration
        self.difficult = difficult
        self.ingredients = ingredients
        self.category = category
        self.subcategories = subcategories
    }
}

extension Recipe : Equatable {
    public static func == (lhs: Recipe, rhs: Recipe) -> Bool {
        return (lhs.name == rhs.name &&
            lhs.description == rhs.description &&
            lhs.duration == rhs.duration &&
            lhs.difficult == rhs.difficult &&
            lhs.ingredients == rhs.ingredients &&
            lhs.category == rhs.category &&
            lhs.subcategories == rhs.subcategories) ? true : false
    }
}
