//
//  GetSubcategoryTypesUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetSubcategoryTypesUseCase
 
 Implementation of the logic when we want to get the subcategory types data of the system
 */
class GetSubcategoryTypesUseCase : GetSubcategoryTypesProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the get subcategory types functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the GetSubcategoryTypesUseCase class
     - Parameter repository: The repository layer to call the get subcategory types functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Call the get subcategory types functionality implemented in the Repository layer
     - Returns: An Observable returning a SubcategoryRecipeTypesResponse object
     */
    func getSubcategoryTypes() -> Observable<SubcategoryRecipeTypesResponse> {
        return repository.getSubcategoryTypes()
            .do(onNext: { _ in
                
            }, onError: { (error) in

            })
    }
}
