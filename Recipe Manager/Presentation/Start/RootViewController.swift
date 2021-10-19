//
//  RootViewController.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 RootViewController
 
 This class is responsible for the main routing flows of the app, i.e., it switches from one app-flow to another one such as, for example, from the splash-login app flow to the main app-flow (main screen).
 
 */
class RootViewController: UIViewController {
    
    // MARK: - Properties & Initialization
    
    /// The reference to the UIViewController currently being displayed
    private var current: UIViewController
    
    /**
     Initialization method for the class. When it is called, the splash screen is set
     */
    init() {
        self.current = SplashVC()
        super.init(nibName: nil, bundle: nil)
    }
    
    /**
     Returns an object initialized from data in a given unarchiver
     - Parameter aDecoder: unarchiver object
     */
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     Lifecycle method called when the object is initializing. The currently displayed UIViewController is attached to the window.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChild(current)
        current.view.frame = view.bounds
        view.addSubview(current.view)
        current.didMove(toParent: self)
    }
    
    
    // MARK: - Display screens
    
    /**
     Display the splash-login app flow screen
     */
    func showStartScreen() {
        let loginVC = Application.shared.start_cleanArchitectureConfiguration()
        addChild(loginVC)
        loginVC.view.frame = view.bounds
        view.addSubview(loginVC.view)
        loginVC.didMove(toParent: self)
        current.willMove(toParent: nil)
        current.view.removeFromSuperview()
        current.removeFromParent()
        current = loginVC
    }
    
    /**
     Display the login screen again after logging out the user
     */
    func switchToLogin() {
        let logoutScreen = Application.shared.start_cleanArchitectureConfiguration()
        self.current = animateSlideOutTransition(from: current, to: logoutScreen)
    }
    
    /**
     Display the main app flow screens
     */
    func switchToMainScreen() {
        let mainTabBarController = Application.shared.main_cleanArchitectureConfiguration()
        mainTabBarController.selectedViewController = mainTabBarController.viewControllers?[1]
        self.current = animateFadeTransition(from: current, to: mainTabBarController)
    }
}
