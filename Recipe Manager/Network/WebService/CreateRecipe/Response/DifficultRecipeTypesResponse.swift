//
//  DifficultRecipeTypesRequest.swift
//  Recipe Manager
//


import Foundation

/**
 DifficultRecipeTypesResponse
 
 Entity representing the difficult of the recipe
 */
public struct DifficultRecipeTypesResponse: Encodable {
    
    var difficultTypes: [Difficult]
    
    init(difficultTypes: [Difficult]) {
        self.difficultTypes = difficultTypes
    }
}

extension DifficultRecipeTypesResponse : Equatable {
    public static func == (lhs: DifficultRecipeTypesResponse, rhs: DifficultRecipeTypesResponse) -> Bool {
        return (lhs.difficultTypes == rhs.difficultTypes) ? true : false
    }
}
