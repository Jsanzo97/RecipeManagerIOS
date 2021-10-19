//
//  SignUpProtocol.swift
//  Recipe Manager
//


import Foundation

/**
 SignUpRequest
 
 JSON body sent with the sign up web service call
 
 */
struct SignUpRequest {
    let username : String
    let password : String
}
