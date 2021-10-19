//
//  LoginPresenter.swift
//  Recipe Manager
//


import Foundation
import RxSwift

/**
 LoginPresenter
 
 Object responsible for sending the user login requests to the Interactor layer and providing the response to the view, telling the view what to display and when
 */
class LoginPresenter {
    
    // MARK: - Properties & Initialization
    
    /// Rx PublishSubject responsible for sending the events from the presenter to the UIViewController - LoginVC
    private var loginViewState : PublishSubject<LoginViewState> = PublishSubject<LoginViewState>()
    /// Rx PublishSubject observable to the one the UIViewController - LoginVC is attached to get the all the possible states
    var loginViewStateObservable : Observable<LoginViewState> {
        return loginViewState.asObservable()
    }
    
    /// The current ViewState of the UIViewController attached - LoginVC
    private var currentViewState : LoginViewState!
    
    /// Login use case abstraction used to let the users access the system
    private let loginUseCase: LoginProtocol
    /// Sign up use case abstraction used to let the users register in the system
    private let signUpUseCase: SignUpProtocol
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /**
     Initialization method for the class
     - Parameter loginUseCase: the interactor layer to call the log in functionality
     - Parameter signUpUseCase: the interactor layer to call the sign up functionality
     */
    init(loginUseCase: LoginProtocol, signUpUseCase: SignUpProtocol) {
        self.loginUseCase = loginUseCase
        self.signUpUseCase = signUpUseCase
    }
    
    
    // MARK: - Logic
    
    /**
     Call the Login use case to log in the system. If it succeeds, the presenter sets the UIViewController to the "openMainScreen" state. If it does not succeed, the presenter tells the UIViewController that an error must be displayed
     - Parameter user: user input for username
     - Parameter password: user input for password
     */
    func login(user: String, password: String) {
        
        if user.isEmpty || password.isEmpty {
            displayError(with: UIMessages.errorEmptyUsernameOrPasswordTitle, and: UIMessages.errorEmptyUsernameOrPassword)
        } else {
            self.currentViewState = LoginViewState.loading
            self.loginViewState.onNext(self.currentViewState)
            
            loginUseCase.login(with: user, and: password)
                .subscribe { completable in
                    switch completable {
                    case .completed:
                        #if DEBUG
                        print("loginUseCase completed successfully")
                        #endif

                        self.currentViewState = LoginViewState.openMainScreen
                        self.loginViewState.onNext(self.currentViewState)

                    case .error(let error):
                        let nsError = error as NSError
                        #if DEBUG
                        print("loginUseCase completed with an error: \(error.localizedDescription)")
                        #endif
                        if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                            self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                        } else if nsError.code == Constants.Network.TimeoutErrorCode {
                            self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                        } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                            self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                        } else {
                            self.displayError(with: UIMessages.errorWrongCredentialsTitle, and: UIMessages.errorWrongCredentials)
                        }
                    }
                }
                .disposed(by: self.disposeBag)
        }
        
    }
    
    /**
     Call the Sign up use case to sign up in the system. If it succeeds, the presenter sets the UIViewController to the "openMainScreen" state. If it does not succeed, the presenter tells the UIViewController that an error must be displayed
     - Parameter user: user input for username
     - Parameter password: user input for password
     */
    func signUp(user: String, password: String) {
        if user.isEmpty || password.isEmpty {
            displayError(with: UIMessages.errorEmptyUsernameOrPasswordTitle, and: UIMessages.errorEmptyUsernameOrPassword)
        } else {
            self.currentViewState = LoginViewState.loading
            self.loginViewState.onNext(self.currentViewState)
            
            signUpUseCase.signUp(with: user, and: password)
                .subscribe { completable in
                    switch completable {
                    case .completed:
                        #if DEBUG
                        print("signUpUseCase completed successfully")
                        #endif

                        self.currentViewState = LoginViewState.openMainScreen
                        self.loginViewState.onNext(self.currentViewState)

                    case .error(let error):
                        let nsError = error as NSError
                        #if DEBUG
                        print("signUpUseCase completed with an error: \(error.localizedDescription)")
                        #endif
                        if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                            self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                        } else if nsError.code == Constants.Network.TimeoutErrorCode {
                            self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                        } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                            self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                        } else {
                            self.displayError(with: UIMessages.errorUserAlreadyExistsTitle, and: UIMessages.errorUserAlreadyExists)
                        }
                    }
                }
                .disposed(by: self.disposeBag)
        }
    }
    
    /**
     Set the UIViewController to error state by displaying an error alert
     - Parameter title: the title for the error alert
     - Parameter message: the message to be displayed inside the error alert
     */
    func displayError(with title: String, and message: String) {
        self.currentViewState = LoginViewState.error(title: title, message: message)
        self.loginViewState.onNext(self.currentViewState)
    }
}
