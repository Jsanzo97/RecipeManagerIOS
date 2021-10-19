//
//  LoginProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 LoginProtocol
 
 List of methods needed for the Login functionality
 */
public protocol LoginProtocol {
    func login(with username: String, and password: String) -> Completable
}
