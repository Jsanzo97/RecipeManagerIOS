//
//  GetSubcategoryTypesProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetSubcategoryTypesProtocol
 
 List of methods needed for the GetSubcategoryTypesProtocol functionality
 */
public protocol GetSubcategoryTypesProtocol {
    func getSubcategoryTypes() -> Observable<SubcategoryRecipeTypesResponse>
}
