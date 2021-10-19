//
//  Constants.swift
//  Recipe Manager
//


import Foundation
import UIKit
import CoreLocation

/**
 Constants
 
 This struct contains all constant values used in the code
 */
class Constants {
    
    static let endpoint = "http://ec2-52-28-187-11.eu-central-1.compute.amazonaws.com"
    
    struct Storyboard {
        static let Start = "Start"
        static let Main = "Main"
        static let NewRecipe = "NewRecipe"
        static let Home = "Home"
        static let Close = "Close"
    }
    
    struct ViewController {
        static let LoginVC = "LoginVC"
    }
    
    struct NavigationController {
        static let Main = "HomeNavigator"
    }
    
    struct Options {
        static let OK = "OK"
    }
    
    struct UserDefaultsKeys {
        static let tabBarBounds = "tabBarBounds"
        static let usernameKey = "username"
    }
    
    struct tabBarSizes {
        static let lateralViewWidth:CGFloat = 2
        static let bottomViewHeight:CGFloat = 4
        static let bottomSpace:CGFloat = 30
        static let bottomSpaceSmallDevice:CGFloat = 15
        static let radius:CGFloat = 440
        static let spaceToCenter:CGFloat = 280
        static let spaceToCenterSmallDevice:CGFloat = 315
    }
    
    struct MoveView {
        static let loginVC: CGFloat = 250
        static let viewBehindTabBar: CGFloat = 160
        static let spaceBetweenSelectFiltersAndTabBar:CGFloat = 175
        static let spaceBetweenSelectFiltersAndTabBarSmallDevice:CGFloat = 140
    }
    
    struct font {
        static let fontSizeForSmallDevice:CGFloat = 13
    }
    
    struct Network {
        static let maxRetries = 3
        static let authHeader = "Authorization"
        static let BadRequestErrorCode = "400"
        static let AccessDeniedErrorCode = "401"
        static let InternalServerErrorCode = "500"
        static let NoInternetConnection = -1009
        static let TimeoutErrorCode = -1001
        static let WifiNotWorking = 4
        static let Error = "error"
    }
    
    struct JSONEntity {
        static let bookRecipesKey = "recipes"
    }
    
    struct Urls {
        
        // MARK: - Login
        static let login = "/logIn" // HTTP method: POST
        static let signUp = "/signUp" // HTTP method: POST
        static let getRecipesBook = "/recipes" // HTTP method: GET
        static let removeRecipe = "/recipe/withName" // HTTP method: DELETE
        static let createRecipe = "/recipe" // HTTP method: POST
        static let getDifficultTypes = "/recipes/difficulties" // HTTP method: GET
        static let getIngredientTypes = "/recipes/ingredientTypes" // HTTP method: GET
        static let getCategories = "/recipes/categories" // HTTP method: GET
        static let getSubcategories = "/recipes/subcategories" // HTTP method: GET
        
    }
}
