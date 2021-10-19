//
//  CreateRecipeUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 CreateRecipeUseCase
 
 Implementation of the logic when we want to create new recipe in the system
 */
class CreateRecipeUseCase : CreateRecipeProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the create recipe functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the CreateRecipeUseCase class
     - Parameter repository: The repository layer to call the createRecipe functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Call the create recipe functionality implemented in the Repository layer
     - Parameter username: username to create the recipe
     - Parameter recipe: recipe to be stored in the system
     - Returns: A Rx Completable
     */
    func createRecipe(username: String, recipe: Recipe) -> Completable {
        return Completable.create(subscribe: { (observer) -> Disposable in
            self.repository.createRecipe(username: username, recipe: recipe)
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
