//
//  LoginRequest.swift
//  Recipe Manager
//


import Foundation

/**
 LoginRequest
 
 JSON body sent with the login web service call
 
 */
struct LoginRequest {
    let username : String
    let password : String
}
