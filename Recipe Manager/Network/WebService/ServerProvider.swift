//
//  ServerProvider.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 ServerProvider
 
 The class providing the calls to the web services offered by the main endpoint server of the system. It conforms the ServerProviderProtocol.
 */
class ServerProvider : ServerProviderProtocol {
    
    // MARK: - Properties & Initialization
    
    /// The URL identifier of the server from the one the data is obtained
    private let apiEndpoint: String
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the ServerProvider class
     */
    public init() {
        apiEndpoint = Constants.endpoint
    }
    
    // MARK: - Login
    
    /**
     Create the request structure with parameters and call the login web service
     - Parameter username: The username string who wants to login the app
     - Parameter password: The user's password which is used to login the app
     - Returns: A completable object
     */
    func login(username: String, password: String) -> Completable {
        let network = NetworkVoid(apiEndpoint)
        let webService = LoginNetwork(network: network)
        let loginParameters = LoginRequest(username: username,password: password)
        return webService.login(with: loginParameters)
    }
    
    /**
     Create the request structure with parameters and call the signUp web service
     - Parameter username: The username string who wants to signUp the app
     - Parameter password: The user's password which is used to signUp the app
     - Returns: A completable object
     */
    func signUp(username: String, password: String) -> Completable {
        let network = NetworkVoid(apiEndpoint)
        let webService = SignUpNetwork(network: network)
        let signUpParameters = SignUpRequest(username: username,password: password)
        return webService.signUp(with: signUpParameters)
    }
    
    // MARK: - HomeVC

    /**
     Create the request structure with parameters and call the new recipe web service
     - Parameter username: The username string who wants to retrieve its recipes
     - Returns: An observable object
     */
    func getRecipesBook(username: String) -> Observable<RecipeBook> {
        let network = Network<RecipeBook>(apiEndpoint)
        let webService = GetRecipesBookNetwork(network: network)
        let requestParameters = GetRecipesBookRequest(username: username)
        return webService.getRecipesBook(with: requestParameters)
    }
    
    /**
    Create the request structure with parameters and call the remove recipe web service
    - Parameter username: The username string who wants to remove the recipe
    - Parameter name: The name of the recipe to be removed
    - Returns: A Completable object
    */
    func removeRecipe(name: String, username: String) -> Completable {
        let network = NetworkVoid(apiEndpoint)
        let webService = RemoveRecipeNetwork(network: network)
        let requestParameters = RemoveRecipeRequest(name: name, username: username)
        return webService.removeRecipe(with: requestParameters)
    }
    
    // MARK: - NewRecipe
    /**
    Create the request structure with parameters and call the create recipe web service
    - Parameter username: The username string who wants to create the recipe
    - Parameter recipe: The recipe to be stored
    - Returns: A Completable object
    */
    func createNewRecipe(username: String, recipe: Recipe) -> Completable {
        let network = NetworkVoid(apiEndpoint)
        let webService = CreateRecipeNetwork(network: network)
        let requestParameters = CreateRecipeRequest(
            name: recipe.name, description: recipe.description, durationInHours: recipe.duration, difficult: recipe.difficult, ingredients: recipe.ingredients, category: recipe.category, subcategories: recipe.subcategories
        )
        return webService.createRecipe(with: requestParameters, queryParam: username)
    }
    
    /**
    Create the request structure with parameters and call the get difficult types web service
    - Returns: An oompletable object
    */
    func getDifficicultTypes() -> Observable<DifficultRecipeTypesResponse> {
        let network = Network<DifficultRecipeTypesResponse>(apiEndpoint)
        let webService = DifficultRecipeTypesNetwork(network: network)
        return webService.getDifficultRecipeTypes()
    }
    
    /**
    Create the request structure with parameters and call the get ingredient types web service
    - Returns: An oompletable object
    */
    func getIngredientTypes() -> Observable<IngredientRecipeTypesResponse> {
        let network = Network<IngredientRecipeTypesResponse>(apiEndpoint)
        let webService = IngredientRecipeTypesNetwork(network: network)
        return webService.getIngredientRecipeTypes()
    }
    
    /**
    Create the request structure with parameters and call the get category types web service
    - Returns: An oompletable object
    */
    func getCategoryTypes() -> Observable<CategoryRecipeTypesResponse> {
        let network = Network<CategoryRecipeTypesResponse>(apiEndpoint)
        let webService = CategoryRecipeTypesNetwork(network: network)
        return webService.getCategoryRecipeTypes()
    }
    
    /**
    Create the request structure with parameters and call the get subcategory types web service
    - Returns: An oompletable object
    */
    func getSubcategoryTypes() -> Observable<SubcategoryRecipeTypesResponse> {
        let network = Network<SubcategoryRecipeTypesResponse>(apiEndpoint)
        let webService = SubcategoryRecipeTypesNetwork(network: network)
        return webService.getSubcategoryRecipeTypes()
    }
}
