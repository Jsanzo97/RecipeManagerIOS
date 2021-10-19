//
//  GetrecipesRequest.swift
//  Recipe Manager
//


import Foundation

/**
 GetRecipesBookRequest
 
 JSON body sent with the get recipes book web service call
 
 */
struct GetRecipesBookRequest : Encodable {
    let username : String
}
