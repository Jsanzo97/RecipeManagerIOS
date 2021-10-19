//
//  LoginUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 LoginUseCase
 
 Implementation of the logic when the user wants to log in the app
 */
class LoginUseCase : LoginProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the login functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the LoginUseCase class
     - Parameter repository: The repository layer to call the login functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    
    // MARK: - Logic
    
    /**
     Call the login functionality implemented in the Repository layer
     - Parameter username: username of the user who wants to access the app
     - Parameter password: password of the user who wants to access the app
     - Returns: A Rx Completable
     */
    func login(with username: String, and password: String) -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            self.repository.login(username: username, password: password)
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
