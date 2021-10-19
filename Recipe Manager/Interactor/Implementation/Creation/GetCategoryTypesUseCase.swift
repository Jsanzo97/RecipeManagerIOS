//
//  GetCategoryTypesUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetCategoryTypesUseCase
 
 Implementation of the logic when we want to get the category types data of the system
 */
class GetCategoryTypesUseCase : GetCategoryTypesProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the get category types functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the GetCategoryTypesUseCase class
     - Parameter repository: The repository layer to call the get category types functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Call the get category types functionality implemented in the Repository layer
     - Returns: An Observable returning a CategoryRecipeTypesResponse object
     */
    func getCategoryTypes() -> Observable<CategoryRecipeTypesResponse> {
        return repository.getCategoryTypes()
            .do(onNext: { _ in
                
            }, onError: { (error) in

            })
    }
}
