//
//  GetCategoryTypesProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetCategoryTypesProtocol
 
 List of methods needed for the GetCategoryTypesProtocol functionality
 */
public protocol GetCategoryTypesProtocol {
    func getCategoryTypes() -> Observable<CategoryRecipeTypesResponse>
}
