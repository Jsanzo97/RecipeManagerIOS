//
//  LoginViewState.swift
//  Recipe Manager
//


import Foundation

/**
 LoginViewState
 
 List of possible view states for the login screen
 */
enum LoginViewState {
    case loading
    case error(title: String, message: String)
    case openMainScreen
}

extension LoginViewState : Equatable {
    static func == (lhs: LoginViewState, rhs: LoginViewState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading): return true
        case (.error(let title, let message), .error(let title2, let message2)):
            return (title == title2 && message == message2) ? true : false
        case (.openMainScreen, .openMainScreen):
            return true
        default:
            return false
        }
    }
}
