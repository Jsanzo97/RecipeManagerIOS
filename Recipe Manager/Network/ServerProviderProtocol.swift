//
//  ServerProviderProtocol.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 ServerProviderProtocol
 
 List of methods provided by the server that the app is able to call to get the data of the system.
 */
protocol ServerProviderProtocol {
    
    // MARK: - Login
    func login(username: String, password: String) -> Completable
    func signUp(username: String, password: String) -> Completable
    
    // MARK: - Home
    func getRecipesBook(username: String) -> Observable<RecipeBook>
    func removeRecipe(name: String, username: String) -> Completable
    
    // MARK: - NewRecipe
    func createNewRecipe(username: String, recipe: Recipe) -> Completable
    func getDifficicultTypes() -> Observable<DifficultRecipeTypesResponse>
    func getIngredientTypes() -> Observable<IngredientRecipeTypesResponse>
    func getCategoryTypes() -> Observable<CategoryRecipeTypesResponse>
    func getSubcategoryTypes() -> Observable<SubcategoryRecipeTypesResponse>
}

