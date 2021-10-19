//
//  SignUpProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 SignUpProtocol
 
 List of methods needed for the SignUp functionality
 */
public protocol SignUpProtocol {
    func signUp(with username: String, and password: String) -> Completable
}
