//
//  Difficult.swift
//  Recipe Manager
//


import Foundation

/**
 Difficult
 
 Entity representing the difficult of the recipe
 */
public struct Difficult: Encodable {
    
    var difficult: String
    
    init(difficult: String) {
        self.difficult = difficult
    }
}

extension Difficult : Equatable {
    public static func == (lhs: Difficult, rhs: Difficult) -> Bool {
        return (lhs.difficult == rhs.difficult) ? true : false
    }
}
