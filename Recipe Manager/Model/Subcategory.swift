//
//  Subcategory.swift
//  Recipe Manager
//


import Foundation

/**
 Subcategory
 
 Entity representing the subcategory of the recipe
 */
public struct Subcategory: Encodable {
    
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

extension Subcategory : Equatable {
    public static func == (lhs: Subcategory, rhs: Subcategory) -> Bool {
        return (lhs.name == rhs.name) ? true : false
    }
}
