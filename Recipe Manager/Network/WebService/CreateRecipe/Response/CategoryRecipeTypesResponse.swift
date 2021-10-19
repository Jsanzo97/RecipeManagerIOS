//
//  CategoryRecipeTypesResponse.swift
//  Recipe Manager
//


import Foundation

/**
 CategoryRecipeTypesResponse
 
 Entity representing the category types of the recipe
 */
public struct CategoryRecipeTypesResponse: Encodable {
    
    var categoryTypes: [Category]
    
    init(categoryTypes: [Category]) {
        self.categoryTypes = categoryTypes
    }
}

extension CategoryRecipeTypesResponse : Equatable {
    public static func == (lhs: CategoryRecipeTypesResponse, rhs: CategoryRecipeTypesResponse) -> Bool {
        return (lhs.categoryTypes == rhs.categoryTypes) ? true : false
    }
}
