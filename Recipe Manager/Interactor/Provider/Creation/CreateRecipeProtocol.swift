//
//  CreateRecipeProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 CreateRecipeProtocol
 
 List of methods needed for the CreateRecipeProtocol functionality
 */
public protocol CreateRecipeProtocol {
    func createRecipe(username: String, recipe: Recipe) -> Completable
}
