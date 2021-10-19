//
//  GetIngredientTypesProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetIngredientTypesProtocol
 
 List of methods needed for the GetIngredientTypesProtocol functionality
 */
public protocol GetIngredientTypesProtocol {
    func getIngredientTypes() -> Observable<IngredientRecipeTypesResponse>
}
