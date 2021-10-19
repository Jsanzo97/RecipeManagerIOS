//
//  RepositoryNetwork.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 Repository (network extension)
 
 This extension includes the method calls to the 'networkServerProvider' responsible for providing the server data
 */
extension Repository {
    
    func network_login(username: String, password: String) -> Completable {
        return networkServerProvider.login(username: username, password: password)
    }
    
    func network_signUp(username: String, password: String) -> Completable {
        return networkServerProvider.signUp(username: username, password: password)
    }
    
    func network_getRecipesBook(username: String) -> Observable<RecipeBook> {
        return networkServerProvider.getRecipesBook(username: username)
    }
    
    func network_removeRecipe(name: String, username: String) -> Completable {
        return networkServerProvider.removeRecipe(name: name, username: username)
    }
    
    func network_createRecipe(username: String, recipe: Recipe) -> Completable {
        return networkServerProvider.createNewRecipe(username: username, recipe: recipe)
    }
    
    func network_getDifficulTypes() -> Observable<DifficultRecipeTypesResponse> {
        return networkServerProvider.getDifficicultTypes()
    }
    
    func network_getIngredientTypes() -> Observable<IngredientRecipeTypesResponse> {
        return networkServerProvider.getIngredientTypes()
    }
    
    func network_getCategoryTypes() -> Observable<CategoryRecipeTypesResponse> {
        return networkServerProvider.getCategoryTypes()
    }
    
    func network_getSubcategoryTypes() -> Observable<SubcategoryRecipeTypesResponse> {
        return networkServerProvider.getSubcategoryTypes()
    }

}
