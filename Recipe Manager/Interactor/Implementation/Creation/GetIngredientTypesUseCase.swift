//
//  GetIngredientTypesUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetIngredientTypesUseCase
 
 Implementation of the logic when we want to get the ingredient types of the system
 */
class GetIngredientTypesUseCase : GetIngredientTypesProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the get ingredient types functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the GetIngredientTypesUseCase class
     - Parameter repository: The repository layer to call the get ingredient types functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Call the get ingredient types functionality implemented in the Repository layer
     - Returns: An Observable returning a IngredientRecipeTypesResponse object
     */
    func getIngredientTypes() -> Observable<IngredientRecipeTypesResponse> {
        return repository.getIngredientTypes()
            .do(onNext: { _ in
                
            }, onError: { (error) in

            })
    }
}
