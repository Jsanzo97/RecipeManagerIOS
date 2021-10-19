//
//  SignUpUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 SignUpUseCase
 
 Implementation of the logic when the user wants to sign up in the app
 */
class SignUpUseCase : SignUpProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the signUp functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the SignUpUseCase class
     - Parameter repository: The repository layer to call the sign up functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    
    // MARK: - Logic
    
    /**
     Call the sign up functionality implemented in the Repository layer
     - Parameter username: username of the user who wants to register in the app
     - Parameter password: password of the user who wants to register in the app
     - Returns: A Rx Completable
     */
    func signUp(with username: String, and password: String) -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            self.repository.signUp(username: username, password: password)
                .subscribe { completable in
                    switch completable {
                        case .completed:
                            observer(.completed)
                        case .error(let error):
                            observer(.error(error))
                    }
                }
            }
        )
    }
}
