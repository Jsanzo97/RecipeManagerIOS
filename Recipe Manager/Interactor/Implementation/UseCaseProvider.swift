//
//  UseCaseProvider.swift
//  Recipe Manager
//


import Foundation

/**
 UseCaseProvider
 
 Final class responsible for creating all the use cases available in the Interactor layer and that can be exploited by the upper layer whose name is Presentation and the objects using these use cases are called "Presenters".
 */
public final class UseCaseProvider: UseCaseProviderProtocol {
    
    // MARK: - Properties & Initialization
    
    /// Repository layer to store and retrieve data
    private let repository: Repository
    
    /**
     Initialization method for the UseCaseProvider class
     - Parameter repository: Repository layer to store and retrieve data
     */
    init(with repository: Repository) {
        self.repository = repository
    }
    
    
    // MARK: - Login
    
    /**
     - Returns: the use case to be able to login the app
     */
    func makeLoginUseCase() -> LoginProtocol {
        return LoginUseCase(repository: repository)
    }
    
    /**
     - Returns: the use case to be able to sign up the app
     */
    func makeSignUpUseCase() -> SignUpProtocol {
        return SignUpUseCase(repository: repository)
    }
    
    // MARK: - Home
    
    /**
     - Returns: the use case to be able to retrieve the recipes book
     */
    func makeGetRecipesBookUseCase() -> GetRecipesBookProtocol {
        return GetRecipesBookUseCase(repository: repository)
    }
    
    /**
     - Returns: the use case to be able to remove the recipes
     */
    func makeRemoveRecipeUseCase() -> RemoveRecipeProtocol {
        return RemoveRecipeUseCase(repository: repository)
    }
    
    // MARK: - NewRecipe
    
    /**
     - Returns: the use case to be able to create new recipe
     */
    func makeCreateRecipeUseCase() -> CreateRecipeProtocol {
        return CreateRecipeUseCase(repository: repository)
    }
    
    /**
    - Returns: the use case to be able to get difficult types
    */
    func makeGetDifficultTypesUseCase() -> GetDifficultTypesProtocol {
        return GetDifficultTypesUseCase(repository: repository)
    }
    
    /**
    - Returns: the use case to be able to get ingredient types
    */
    func makeGetIngredientTypesUseCase() -> GetIngredientTypesProtocol {
        return GetIngredientTypesUseCase(repository: repository)
    }
    
    /**
    - Returns: the use case to be able to get category types
    */
    func makeGetCategoryTypesUseCase() -> GetCategoryTypesProtocol {
        return GetCategoryTypesUseCase(repository: repository)
    }
    
    /**
    - Returns: the use case to be able to get subcategory types
    */
    func makeGetSubategoryTypesUseCase() -> GetSubcategoryTypesProtocol {
        return GetSubcategoryTypesUseCase(repository: repository)
    }
    
}
