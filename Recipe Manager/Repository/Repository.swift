//
//  Repository.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 Repository
 
 Main Repository layer which is responsible for managing the calls to the network-server and to the local database. Uppers layers should not know what is happening behind the scenes.
 */
class Repository {
    
    // MARK: - Properties & Initialization
    
    /// Bag to dispose added disposables [RxSwift]
    internal let disposeBag = DisposeBag()
    
    
    // MARK: Network
    
    /// ServerProvider allowing the app to communicate with the server
    internal let networkServerProvider: ServerProviderProtocol
    
    // MARK: Initialization
    /**
     Initialization method for the main Repository layer of the app
     - Parameter serverProvider: ServerProvider allowing the app to communicate with the server
     */
    init(serverProvider: ServerProviderProtocol) {
        
        self.networkServerProvider = serverProvider
        
    }
    
    // MARK: - Login
    
    /**
     Call to the web service allowing to log in the app
     - Parameter username: the username of the account that wants to access the app
     - Parameter password: the user's password of the account that wants to log in
     - Returns: A Completable object
     */
    func login(username: String, password: String) -> Completable {
        return network_login(username: username, password: password)
    }
    
    // MARK: - SignUp
    /**
     Call to the web service allowing to register in the app
     - Parameter username: the username of the account that wants to access the app
     - Parameter password: the user's password of the account that wants to log in
     - Returns: A Completable object
     */
    func signUp(username: String, password: String) -> Completable {
        return network_signUp(username: username, password: password)
    }
    
    // MARK: - GetRecipesBook
    /**
     Call to the web service to retrieve the recipes book
     - Parameter username: the username of the account
     - Returns: An Observable with an object of type RecipeBook
     */
    func getRecipesBook(username: String) -> Observable<RecipeBook> {
        return network_getRecipesBook(username: username)
    }
    
    // MARK: - RemoveRecipe
    /**
     Call to the web service to remove the recipes
     - Parameter name: the name of the recipe
     - Returns: A Completable  object
     */
    func removeRecipe(name: String, username: String) -> Completable {
        return network_removeRecipe(name: name, username: username)
    }
    
    // MARK: - NewRecipe
    /**
     Call to the web service to create new recipe
     - Parameter username: the username of the account
     - Parameter recipe: the recipe to be stored
     - Returns: A Completable  object
     */
    func createRecipe(username: String, recipe: Recipe) -> Completable {
        return network_createRecipe(username: username, recipe: recipe)
    }
    
    /**
    Call to the web service to retrieve the difficult types
    - Returns: An Observable with an object of type DifficultRecipeTypesResponse
    */
    func getDifficultTypes() -> Observable<DifficultRecipeTypesResponse> {
        return network_getDifficulTypes()
    }
    
    /**
    Call to the web service to retrieve the ingredient types
    - Returns: An Observable with an object of type IngredientRecipeTypesResponse
    */
    func getIngredientTypes() -> Observable<IngredientRecipeTypesResponse> {
        return network_getIngredientTypes()
    }
    
    /**
    Call to the web service to retrieve the category types
    - Returns: An Observable with an object of type CategoryRecipeTypesResponse
    */
    func getCategoryTypes() -> Observable<CategoryRecipeTypesResponse> {
        return network_getCategoryTypes()
    }
    
    /**
    Call to the web service to retrieve the subcategory types
    - Returns: An Observable with an object of type SubcategoryRecipeTypesResponse
    */
    func getSubcategoryTypes() -> Observable<SubcategoryRecipeTypesResponse> {
        return network_getSubcategoryTypes()
    }

}
