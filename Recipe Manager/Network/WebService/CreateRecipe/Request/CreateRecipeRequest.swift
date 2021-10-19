//
//  CreateRecipeRequest.swift
//  Recipe Manager
//


import Foundation

/**
 CreateRecipeRequest
 
 JSON body sent with the create recipe web service call
 
 */
struct CreateRecipeRequest : Encodable {
    let name : String
    let description: String
    let durationInHours: Double
    let difficult: String
    let ingredients: [Ingredient]
    let category: String
    let subcategories: [Subcategory]
}
