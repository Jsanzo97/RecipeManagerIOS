//
//  UIMessages.swift
//  Recipe Manager
//


import Foundation

/**
 UIMessages
 
 This struct contains all the localized strings used in the UI messages
 */
struct UIMessages {
    
    // MARK: - General
    static let errorServerTitle = NSLocalizedString("Something went wrong", comment: "")
    static let errorServerMessage = NSLocalizedString("Seems like server is not working properly. Please, try it again", comment: "")
    static let errorTimeoutTitle = NSLocalizedString("Connection timeout", comment: "")
    static let errorTimeout = NSLocalizedString("Please, try it again later", comment: "")
    static let errorNoConnectionTitle = NSLocalizedString("Network not available", comment: "")
    static let errorNoConnection = NSLocalizedString("There is no internet connection. Please, check your network/mobile data connection and try again", comment: "")
    static let errorGeneralTitle = NSLocalizedString("Error", comment: "")
    static let errorGeneral = NSLocalizedString("It has not been possible to process your request. Please, try it again", comment: "")
    static let errorEmptyFields = NSLocalizedString("Please, check that you have filled the required fields appropriately and try again", comment: "")
    
    // MARK: - Login
    static let usernamePlaceholder = NSLocalizedString("Username", comment: "")
    static let errorEmptyUsernameOrPasswordTitle = NSLocalizedString("Empty username/password", comment: "")
    static let errorEmptyUsernameOrPassword = NSLocalizedString("It is not possible to log in the system without entering both the username and the password. Please, check both fields and try again", comment: "")
    static let errorWrongCredentialsTitle = NSLocalizedString("Wrong credentials", comment: "")
    static let errorWrongCredentials = NSLocalizedString("Please, enter the correct username and password and try again", comment: "")
    static let errorUserAlreadyExistsTitle = NSLocalizedString("User already exists", comment: "")
    static let errorUserAlreadyExists = NSLocalizedString("User with this username already exists in the system", comment: "")
    static let errorNoExistingUsernameTitle = NSLocalizedString("Username not found", comment: "")
    static let errorNoExistingUsername = NSLocalizedString("Please, ensure that you are typing it correctly and try again.", comment: "")
    
    
    // MARK: - Home
    static let errorGetRecipesBookTitle = NSLocalizedString("Recipes book error", comment: "")
    static let errorGetRecipesBook = NSLocalizedString("It has not been possible to get the recipes book data. Please, try it again", comment: "")
    static let errorRemoveRecipeTitle = NSLocalizedString("Recipes book error", comment: "")
    static let errorRemoveRecipe = NSLocalizedString("It has not been possible to remove the recipe. Please, try it again", comment: "")
    
    // MARK: - NewRecipe
    static let successNewRecipeTitle = NSLocalizedString("Done!", comment: "")
    static let successNewRecipeMessage = NSLocalizedString("New recipe has been created", comment: "")
    static let emptyRecipeFieldsTitle = NSLocalizedString("Error", comment: "")
    static let emptyRecipeFieldsMessage = NSLocalizedString("Cannot be empty fields, please check it", comment: "")
    static let errorGetDifficultDataTitle = NSLocalizedString("Error", comment: "")
    static let errorGetDifficultDataTMessage = NSLocalizedString("It has not been possible to retrieve the difficult types from the server", comment: "")
    static let errorGetIngredientsDataTitle = NSLocalizedString("Error", comment: "")
    static let errorGetIngredientsDataTMessage = NSLocalizedString("It has not been possible to retrieve the ingredient types from the server", comment: "")
    static let errorGetCategoryDataTitle = NSLocalizedString("Error", comment: "")
    static let errorGetCategoryDataTMessage = NSLocalizedString("It has not been possible to retrieve the category types from the server", comment: "")
    static let errorGetSubcategoryDataTitle = NSLocalizedString("Error", comment: "")
    static let errorGetSubcategoryDataTMessage = NSLocalizedString("It has not been possible to retrieve the subcategory types from the server", comment: "")
    static let errorCreateNewRecipeTitle = NSLocalizedString("Error", comment: "")
    static let errorCreateNewRecipeMessage = NSLocalizedString("It has not been possible to create the recipe", comment: "")

}
