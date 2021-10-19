//
//  Application.swift
//  Recipe Manager
//

import Foundation
import UIKit

final class Application  {
    
    // MARK: - SINGLETON
    
    /// The reference to the object-singleton
    static let shared = Application()

    // MARK: - Properties & Initialization
    
    /// The abstraction layer of the data repository
    var repository : Repository!
    /// The abstraction layer of the Interactor.
    private var useCaseProvider : UseCaseProvider!
    
    // MARK: - Clean Architecture Logic
    
    /**
     Start the app by creating the data repository and interactor layers
     - Parameter mainWindow: The UIWindow in which the app is framed. Cannot be empty
     */
    func startApp(mainWindow: UIWindow) {
        repository = Repository(serverProvider: ServerProvider())
        useCaseProvider = UseCaseProvider(with: repository)
        
        mainWindow.rootViewController = RootViewController()
        mainWindow.makeKeyAndVisible()
    }
    
    /**
     Connect the layers of the app (VIPER) for the login screen
     - Returns: The start navigation controller
     */
    func start_cleanArchitectureConfiguration() -> UINavigationController {
        let startStoryBoardName = Constants.Storyboard.Start
        let startStoryboard = UIStoryboard(name: startStoryBoardName, bundle: nil)
        let start_navController = startStoryboard.instantiateInitialViewController() as! UINavigationController
        let loginVC = start_navController.topViewController as! LoginVC 
        let loginUseCase = useCaseProvider.makeLoginUseCase()
        let signUpUseCase = useCaseProvider.makeSignUpUseCase()
        let loginPresenter = LoginPresenter(loginUseCase: loginUseCase, signUpUseCase: signUpUseCase)
        loginVC.presenter = loginPresenter
        
        return start_navController
    }
    
    /**
     Connect the layers of the app (VIPER) for the main screens
     - Returns: the main tab bar controller managing the main app tabBar
     */
    func main_cleanArchitectureConfiguration() -> UITabBarController {
        let tabBarController = MainTabBarController()
        tabBarController.tabBar.barTintColor = Colors.mainBlue
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for:.normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for:.selected)
        
        // New recipe
        configureNewRecipe(with: tabBarController)

        // Home
        configureHome(with: tabBarController)

        // Close session
        configureClose(with: tabBarController)
        
        return tabBarController
    }
    
    /**
     Set up VIPER layers for New Recipe screen
     - Parameter tabBarController: The UITabBarController managing the main screens
    */
    private func configureNewRecipe(with tabBarController: UITabBarController) {
        let newRecipe_navController = tabBarController.viewControllers?[0] as! UINavigationController
        newRecipe_navController.navigationBar.barTintColor = Colors.mainBlue
        newRecipe_navController.navigationBar.tintColor = Colors.white
        let newRecipeVC = newRecipe_navController.topViewController as! NewRecipeVC
        let createRecipeUseCase = useCaseProvider.makeCreateRecipeUseCase()
        let getDifficultsUseCase = useCaseProvider.makeGetDifficultTypesUseCase()
        let getIngredientTypesUseCase = useCaseProvider.makeGetIngredientTypesUseCase()
        let getCategoryTypesUseCase = useCaseProvider.makeGetCategoryTypesUseCase()
        let getSubcategoryTypesUseCase = useCaseProvider.makeGetSubategoryTypesUseCase()
        let newRecipePresenter = NewRecipePresenter(createRecipeUseCase: createRecipeUseCase, getDiffiultTypesUseCase: getDifficultsUseCase, getIngredientTypesUseCase: getIngredientTypesUseCase, getCategoryTypesUseCase: getCategoryTypesUseCase, getSucategoryTypesUseCase: getSubcategoryTypesUseCase)
        newRecipeVC.presenter = newRecipePresenter
    }
    
    /**
     Set up VIPER layers for Home screen
     - Parameter tabBarController: The UITabBarController managing the main screens
     */
    private func configureHome(with tabBarController: UITabBarController) {
        let home_navController = tabBarController.viewControllers?[1] as! UINavigationController
        home_navController.navigationBar.barTintColor = Colors.mainBlue
        home_navController.navigationBar.tintColor = Colors.white
        let homeVC = home_navController.topViewController as! HomeVC
        let getRecipesBookUseCase = useCaseProvider.makeGetRecipesBookUseCase()
        let removeRecipeUseCase = useCaseProvider.makeRemoveRecipeUseCase()
        let homePresenter = HomePresenter(getRecipesBookUseCase: getRecipesBookUseCase, removeRecipeUseCase: removeRecipeUseCase)
        homeVC.presenter = homePresenter
    }
    
    /**
     Set up VIPER layers for Close screen
     - Parameter tabBarController: The UITabBarController managing the main screens
     */
    private func configureClose(with tabBarController: UITabBarController) {
        let close_navController = tabBarController.viewControllers?[2] as! UINavigationController
        close_navController.navigationBar.barTintColor = Colors.mainBlue
        close_navController.navigationBar.tintColor = Colors.white
    }
}
