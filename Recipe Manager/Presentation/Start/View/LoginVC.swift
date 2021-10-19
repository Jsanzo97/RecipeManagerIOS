//
//  LoginVC.swift
//  Recipe Manager
//


import Foundation
import UIKit
import RxSwift
import SVProgressHUD

class LoginVC: UIViewController, UITextFieldDelegate {

    // MARK: - Properties & Initialization

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var login: RoundButton!
    @IBOutlet weak var signUp: RoundButton!
    public var presenter: LoginPresenter!
    private let disposeBag = DisposeBag()
    
    /**
     Lifecycle method called when the object is initializing
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setColorForStatusBar(color: UIColor.white)
        
        userNameTextField.attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("Username", comment: ""),
            attributes: [NSAttributedString.Key.foregroundColor: Colors.mainBlue])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("Password", comment: ""),
            attributes: [NSAttributedString.Key.foregroundColor: Colors.mainBlue])
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
        self.hideKeyboardWhenTappedAround()
        
        setupViewStateObserver()
        
    }
    
    /**
     Lifecycle method called when the view is going to be displayed
     */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        subscribeToKeyboardNotifications()
        setColorForStatusBar(color: UIColor.white)
    }
    
    
    // MARK: - UI Logic (Presenter -> UIViewController)
    
    /**
     This UIViewController subscribes to the loginViewStateObservable to get the current view state and display it
     */
    func setupViewStateObserver() {
        presenter.loginViewStateObservable
            .subscribe(
                onNext: { [unowned self] viewState in
                    DispatchQueue.main.async {
                        switch (viewState) {
                        case .loading:
                            self.displayLoadingIndicator()
                        case .error(let title, let message):
                            self.displayError(with: title, and: message)
                        case .openMainScreen:
                            self.navigateMainScreen()
                        }
                    }
                }
            )
            .disposed(by: disposeBag)
    }
    
    /**
     Navigate to the Main Screen when the login is successful
     */
    func navigateMainScreen() {
        SVProgressHUD.dismiss()
        UserDefaults.standard.set(userNameTextField.text, forKey: Constants.UserDefaultsKeys.usernameKey)
        AppDelegate.shared.rootViewController.switchToMainScreen()
    }
    
    /**
     Let the user know that the app is performing an operation which needs time
     */
    func displayLoadingIndicator() {
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(Colors.lightGrey)
        SVProgressHUD.setForegroundColor(Colors.black)
        SVProgressHUD.show()
    }
    
    
    // MARK: - Auxiliary
    
    /**
     Let the user know that an error has ocurred during the course of an operation
     - Parameter title: title for error message
     - Parameter message: error message inside the view
     */
    func displayError(with title: String, and message: String) {
        print("ERROR: \(message)")
        SVProgressHUD.dismiss()
        AlertsManager.alert(caller: self, message: message, title: title) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    /**
     Asks the delegate if the text field should process the pressing of the return button.
     - Parameter textField: text field whose return button was pressed
     - Returns: YES if the text field should implement its default behavior for the return button; otherwise, NO.
     */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
        }
        return true
    }
    
    
    // MARK: - Keyboard
    /**
     Get view Y point
     */
    private func getViewYShift(notification: Notification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height - 128.0
    }
    
    /**
     Method when keyboard is going to show
     */
    @objc func keyboardWillShow(_ notification: Notification) {
        view.frame.origin.y = -getViewYShift(notification: notification)
    }
    
    /**
     Method when keyboard is going to hide
     */
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    /**
     Dismiss keyboard if user touches outside of keyboard view
     */
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    /**
     Subscribe to keyboard events
     */
    internal func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    // MARK: - Actions (UIViewController -> Presenter)
    
    /**
     Action to log in the app after the user has entered the user & password
     - Parameter sender: the caller of the action (login button)
     */
    @IBAction func login(_ sender: Any) {
        presenter.login(user: userNameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
    /**
    Action to sign up in the app after the user has entered the user & password
    - Parameter sender: the caller of the action (sign up button)
    */
    @IBAction func signUp(_ sender: Any) {
        presenter.signUp(user: userNameTextField.text ?? "", password: passwordTextField.text ?? "")
    }
}
