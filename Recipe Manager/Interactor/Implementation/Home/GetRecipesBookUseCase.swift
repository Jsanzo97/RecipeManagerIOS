//
//  GetRecipesBookUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetRecipesBookUseCase
 
 Implementation of the logic when we want to get the recipes book data of the system
 */
class GetRecipesBookUseCase : GetRecipesBookProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the get recipe book functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the GetRecipesBookUseCase class
     - Parameter repository: The repository layer to call the get recipe book functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Call the get recipes functionality implemented in the Repository layer
     - Parameter username: username to retrieve the recipes
     - Returns: An Observable returning a RecipeBook object
     */
    func getRecipesBook(with username: String) -> Observable<RecipeBook> {
        return repository.getRecipesBook(username: username)
            .do(onNext: { _ in

            }, onError: { (error) in

            })
    }
}
