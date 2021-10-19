//
//  IngredientRecipeTypesResponse.swift
//  Recipe Manager
//


import Foundation

/**
 IngredientRecipeTypesResponse
 
 Entity representing the ingredient types of the recipe
 */
public struct IngredientRecipeTypesResponse: Encodable {
    
    var ingredientTypes: [IngredientType]
    
    init(ingredientTypes: [IngredientType]) {
        self.ingredientTypes = ingredientTypes
    }
}

extension IngredientRecipeTypesResponse : Equatable {
    public static func == (lhs: IngredientRecipeTypesResponse, rhs: IngredientRecipeTypesResponse) -> Bool {
        return (lhs.ingredientTypes == rhs.ingredientTypes) ? true : false
    }
}
