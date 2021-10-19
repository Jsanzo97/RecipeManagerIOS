//
//  Category.swift
//  Recipe Manager
//


import Foundation

/**
 Category
 
 Entity representing the category of the recipe
 */
public struct Category: Encodable {
    
    var category: String
    
    init(category: String) {
        self.category = category
    }
}

extension Category : Equatable {
    public static func == (lhs: Category, rhs: Category) -> Bool {
        return (lhs.category == rhs.category) ? true : false
    }
}
