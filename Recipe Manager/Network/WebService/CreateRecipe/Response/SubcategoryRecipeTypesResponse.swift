//
//  SubcategoryRecipeTypesResponse.swift
//  Recipe Manager
//


import Foundation

/**
 SubcategoryRecipeTypesResponse
 
 Entity representing the subcategory types of the recipe
 */
public struct SubcategoryRecipeTypesResponse: Encodable {
    
    var subcategoryTypes: [Subcategory]
    
    init(subcategoryTypes: [Subcategory]) {
        self.subcategoryTypes = subcategoryTypes
    }
}

extension SubcategoryRecipeTypesResponse : Equatable {
    public static func == (lhs: SubcategoryRecipeTypesResponse, rhs: SubcategoryRecipeTypesResponse) -> Bool {
        return (lhs.subcategoryTypes == rhs.subcategoryTypes) ? true : false
    }
}
