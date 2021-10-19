//
//  SplashVC.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 SplashVC
 
 UIViewController responsible for displaying the first screen when the app is initiating. This ViewController could be used to add an animation or something before opening the first working screen for the users.
 */
class SplashVC: UIViewController {
    
    /**
     Lifecycle method called when the object is initializing
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        openApp()
    }
    
    /**
      Asynchronous task that takes place in the Splash screen when the app is loading
     */
    private func openApp() {
        DispatchQueue.main.async {
            AppDelegate.shared.rootViewController.showStartScreen()
        }
    }

}
