//
//  RemoveRecipeUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 RemoveRecipeUseCase
 
 Implementation of the logic when we want to remove the recipes book data of the system
 */
class RemoveRecipeUseCase : RemoveRecipeProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the remove recipe functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the RemoveRecipeUseCase class
     - Parameter repository: The repository layer to call the remove recipe functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Call the remove recipes functionality implemented in the Repository layer
     - Parameter name: name of the recipe to remove
     - Returns: A Rx Completable
     */
    func removeRecipe(with name: String, username: String) -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            self.repository.removeRecipe(name: name, username: username)
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
