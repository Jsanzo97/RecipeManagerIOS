//
//  GetDifficultTypesProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetDifficultTypesProtocol
 
 List of methods needed for the GetDifficultTypesProtocol functionality
 */
public protocol GetDifficultTypesProtocol {
    func getDifficultTypes() -> Observable<DifficultRecipeTypesResponse>
}
