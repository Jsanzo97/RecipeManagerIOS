//
//  GetRecipesBookProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 GetRecipesBookProtocol
 
 List of methods needed for the GetRecipesBook functionality
 */
public protocol GetRecipesBookProtocol {
    func getRecipesBook(with username: String) -> Observable<RecipeBook>
}
