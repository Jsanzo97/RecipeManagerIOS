//
//  RemoveRecipeProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 RemoveRecipeProtocol
 
 List of methods needed for the removeRecipe functionality
 */
public protocol RemoveRecipeProtocol {
    func removeRecipe(with name: String, username: String) -> Completable
}
