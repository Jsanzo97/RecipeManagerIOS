//
//  Ingredient.swift
//  Recipe Manager
//


import Foundation

/**
 Ingredient
 
 Entity representing the ingredient of the recipe
 */
public struct Ingredient: Encodable {
    
    var name: String
    var type: String
    var calories: Double
    
    init(name: String, type: String, calories: Double) {
        self.name = name
        self.type = type
        self.calories = calories
    }
}

extension Ingredient : Equatable {
    public static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        return (lhs.name == rhs.name &&
            lhs.type == rhs.type &&
            lhs.calories == rhs.calories) ? true : false
    }
}
