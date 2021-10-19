//
//  UseCaseProviderProtocol.swift
//  Recipe Manager
//


import Foundation

/**
 UseCaseProviderProtocol
 
 Protocol listing the functions that mut be developed by the class responsible for implementing the logic to create the use cases, i.e., the interactor functionality
 */
protocol UseCaseProviderProtocol {

    func makeLoginUseCase() -> LoginProtocol
    func makeSignUpUseCase() -> SignUpProtocol
    func makeGetRecipesBookUseCase() -> GetRecipesBookProtocol
    func makeRemoveRecipeUseCase() -> RemoveRecipeProtocol
    func makeCreateRecipeUseCase() -> CreateRecipeProtocol
    func makeGetDifficultTypesUseCase() -> GetDifficultTypesProtocol
    func makeGetIngredientTypesUseCase() -> GetIngredientTypesProtocol
    func makeGetCategoryTypesUseCase() -> GetCategoryTypesProtocol
    func makeGetSubategoryTypesUseCase() -> GetSubcategoryTypesProtocol
    
}
