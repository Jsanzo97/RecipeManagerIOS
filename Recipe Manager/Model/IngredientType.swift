//
//  IngredientType.swift
//  Recipe Manager
//


import Foundation

/**
 IngredientType
 
 Entity representing the type of the ingredient
 */
public struct IngredientType: Encodable {
    
    var ingredientType: String
    
    init(ingredientType: String) {
        self.ingredientType = ingredientType
    }
}

extension IngredientType : Equatable {
    public static func == (lhs: IngredientType, rhs: IngredientType) -> Bool {
        return (lhs.ingredientType == rhs.ingredientType) ? true : false
    }
}
