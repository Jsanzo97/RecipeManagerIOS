//
//  CloseVC.swift
//  Recipe Manager
//


import Foundation
import UIKit

class CloseVC: UIViewController {
    
    // MARK: - Properties & Initialization
    
    @IBOutlet weak var closeViewBottom: NSLayoutConstraint!
    
    /**
    Lifecycle method called when the object is initializing
    */
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /**
    Lifecycle method called when the view is going to be displayed
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        closeViewBottom.constant = -Constants.MoveView.viewBehindTabBar
    }
    
    /**
    Action close session in the app
    - Parameter sender: the caller of the action (sign up button)
    */
    @IBAction func closeSessionAction(_ sender: Any) {
        UserDefaults.standard.set("", forKey: Constants.UserDefaultsKeys.usernameKey)
        AppDelegate.shared.rootViewController.switchToLogin()
    }
}
