//
//  AlertsManager.swift
//  Recipe Manager
//


import Foundation
import UIKit

class AlertsManager {
    
    class func alert(caller: UIViewController, message: String, title: String = "", okActionHandler: @escaping () -> Void) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: Constants.Options.OK, style: .default) { _ in
            okActionHandler()
        }
        alertController.addAction(OKAction)
        DispatchQueue.main.async {
            caller.present(alertController, animated: true, completion: nil)
        }
    }
}
