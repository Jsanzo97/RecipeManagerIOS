//
//  RemoveRecipeRequest.swift
//  Recipe Manager
//


import Foundation

/**
 RemoveRecipeRequest
 
 JSON body sent with the remove recipes web service call
 
 */
struct RemoveRecipeRequest : Encodable {
    let name : String
    let username: String
}
