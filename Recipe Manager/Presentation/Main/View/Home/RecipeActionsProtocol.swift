//
//  RecipeActionsProtocol.swift
//  Recipe Manager
//


import Foundation

/**
 RecipeActions protocol to remove recipe or show details
 */
protocol RecipeActionsProtocol: NSObjectProtocol {
    func removeRecipe(name: String)
    func showDetails(name: String)
}
