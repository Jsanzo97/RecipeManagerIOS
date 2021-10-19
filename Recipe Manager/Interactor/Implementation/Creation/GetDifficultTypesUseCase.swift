//
//  GetDifficultTypesUseCase.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetDifficultTypesUseCase
 
 Implementation of the logic when we want to get the difficult recipe types of the system
 */
class GetDifficultTypesUseCase : GetDifficultTypesProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to call the get difficult types functionality
    private let repository: Repository
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the GetDifficultTypesUseCase class
     - Parameter repository: The repository layer to call the get difficult types functionality
     */
    init(repository: Repository) {
        self.repository = repository
    }
    
    // MARK: - Logic
    
    /**
     Call the get difficult types functionality implemented in the Repository layer
     - Returns: An Observable returning a DifficultRecipeTypesResponse object
     */
    func getDifficultTypes() -> Observable<DifficultRecipeTypesResponse> {
        return repository.getDifficultTypes()
            .do(onNext: { _ in
                
            }, onError: { (error) in

            })
    }
}
