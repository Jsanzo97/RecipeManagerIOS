//
//  HomePresenter.swift
//  Recipe Manager
//



import RxSwift

/**
 HomePresenter
 
 Object responsible for sending the user login requests to the Interactor layer and providing the response to the view, telling the view what to display and when
 */
class HomePresenter {
    
    // MARK: - Properties & Initialization
    
    /// Rx PublishSubject responsible for sending the events from the presenter to the UIViewController - HomeVC
    private var homeViewState : PublishSubject<HomeViewState> = PublishSubject<HomeViewState>()
    /// Rx PublishSubject observable to the one the UIViewController - HomeVC is attached to get the all the possible states
    var homeViewStateObservable : Observable<HomeViewState> {
        return homeViewState.asObservable()
    }
    
    /// The current ViewState of the UIViewController attached - HomeVC
    private var currentViewState : HomeViewState!
    
    /// Get recipes use case abstraction used to show the user recipes
    private let getRecipesBookUseCase: GetRecipesBookProtocol
    /// Remove recipe use case abstraction used to remove the user recipes
    private let removeRecipeUseCase: RemoveRecipeProtocol
    /// List to store the active subscriptions of the class
    private var subscriptions = [Disposable]()
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    /// List of the recipes of the user
    private var recipes = [Recipe]()
    
    
    /**
     Initialization method for the class
     - Parameter getRecipesBookUseCase: the interactor layer to call the get user recipes functionality
     - Parameter removeRecipeUseCase: the interactor layer to call the remove recipe functionality
     */
    init(getRecipesBookUseCase: GetRecipesBookProtocol, removeRecipeUseCase: RemoveRecipeProtocol) {
        self.getRecipesBookUseCase = getRecipesBookUseCase
        self.removeRecipeUseCase = removeRecipeUseCase
    }
    

    // MARK: - Logic
    
    /**
     Call the get recipes use case to show the user recipes. If it succeeds, the presenter sets the UIViewController to the "displayRecipes" state. If it does not succeed, the presenter tells the UIViewController that an error must be displayed
     */
    func getRecipesBook() {
        self.currentViewState = HomeViewState.loading
        self.homeViewState.onNext(self.currentViewState)
                
        unsubscribeActiveObservables()
                
        getRecipesBookUseCase.getRecipesBook(with: UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.usernameKey) ?? "")
            .subscribe(
                onNext: { data in
                    self.recipes.removeAll()
                    self.recipes.append(contentsOf: data.recipes)
                },
                onError: { (error) in
                    let nsError = error as NSError
                    
                    if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                        self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                    } else if nsError.code == Constants.Network.TimeoutErrorCode {
                        self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                    } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                        self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                    } else {
                        self.displayError(with: UIMessages.errorGetRecipesBookTitle, and: UIMessages.errorGetRecipesBook)
                    }
                },
                onCompleted: {
                    self.currentViewState = HomeViewState.displayRecipes(recipes: self.recipes)
                    self.homeViewState.onNext(self.currentViewState)
                }
            )
        .disposed(by: self.disposeBag)
    }
    
    /**
     Call the remove recipe use case to remove a recipe. If it succeeds, the presenter sets the UIViewController to the "removedRecipe" state. If it does not succeed, the presenter tells the UIViewController that an error must be displayed
     - Parameter name: recipe name to remove it
     */
    func removeRecipe(name: String) {
        
        self.currentViewState = HomeViewState.loading
        self.homeViewState.onNext(self.currentViewState)
        
        removeRecipeUseCase.removeRecipe(with: name, username: UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.usernameKey) ?? "")
            .subscribe { completable in
                switch completable {
                case .completed:
                    #if DEBUG
                    print("removeRecipe completed successfully")
                    #endif

                    self.currentViewState = HomeViewState.removedRecipe
                    self.homeViewState.onNext(self.currentViewState)

                case .error(let error):
                    let nsError = error as NSError
                    #if DEBUG
                    print("removedRecipe completed with an error: \(error.localizedDescription)")
                    #endif
                    if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                        self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                    } else if nsError.code == Constants.Network.TimeoutErrorCode {
                        self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                    } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                        self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                    } else {
                        self.displayError(with: UIMessages.errorRemoveRecipeTitle, and: UIMessages.errorRemoveRecipe)
                    }
                }
            }
            .disposed(by: self.disposeBag)
    }
    
    
    // MARK: - Auxiliary
    
    /**
     Set the UIViewController to error state by displaying an error alert
     - Parameter title: the title for the error alert
     - Parameter message: the message to be displayed inside the error alert
     */
    func displayError(with title: String, and message: String) {
        self.currentViewState = HomeViewState.error(title: title, message: message)
        self.homeViewState.onNext(self.currentViewState)
    }
    
    /**
     Unsubscribe the subscribers observables belonging to this current class object in case there is any active one
     */
    func unsubscribeActiveObservables() {
        for subscription in subscriptions {
            subscription.dispose()
        }
        subscriptions.removeAll()
    }
}
    
