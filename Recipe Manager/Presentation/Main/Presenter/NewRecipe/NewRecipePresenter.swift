//
//  NewRecipePresenter.swift
//  Recipe Manager
//


import RxSwift

/**
 NewRecipePresenter
 
 Object responsible for sending the user new recipe requests to the Interactor layer and providing the response to the view, telling the view what to display and when
 */
class NewRecipePresenter {
    
    // MARK: - Properties & Initialization
    
    /// Rx PublishSubject responsible for sending the events from the presenter to the UIViewController - NewRecipeVC
    private var newRecipeViewState : PublishSubject<NewRecipeViewState> = PublishSubject<NewRecipeViewState>()
    /// Rx PublishSubject observable to the one the UIViewController - NewRecipeVC is attached to get the all the possible states
    var newRecipeViewStateObservable : Observable<NewRecipeViewState> {
        return newRecipeViewState.asObservable()
    }
    
    /// The current ViewState of the UIViewController attached - NewRecipeVC
    private var currentViewState : NewRecipeViewState!
    
    /// Create new recipe use case abstraction used to create new recipes
    private let createRecipeUseCase: CreateRecipeProtocol
    /// Get difficult types use case abstraction used to let the user to choose the recipe difficult
    private let getDifficultTypesUseCase: GetDifficultTypesProtocol
    /// Get ingredient types use case abstraction used to let the user to choose the ingredients types of its recipe
    private let getIngredientTypesUseCase: GetIngredientTypesProtocol
    /// Get category types use case abstraction used to let the user to choose the recipe category
    private let getCategoryTypesUseCase: GetCategoryTypesProtocol
    /// Get subcategory types use case abstraction used to let the user to choose the recipe subcategory
    private let getSubcategoryTypesUseCase: GetSubcategoryTypesProtocol
    /// List to store the active subscriptions of the class
    private var subscriptions = [Disposable]()
    /// Bag to dispose added disposables [RxSwift]
    private let disposeBag = DisposeBag()
    
    private var difficults = [Difficult]()
    private var ingredientTypes = [IngredientType]()
    private var categories = [Category]()
    private var subcategories = [Subcategory]()
    
    
    /**
     Initialization method for the class
     - Parameter createRecipeUseCase: the interactor layer to call the create recipe functionality
     - Parameter getDiffiultTypesUseCase: the interactor layer to call the get difficult types functionality
     - Parameter getIngredientTypesUseCase: the interactor layer to call the get ingredient types functionality
     - Parameter getCategoryTypesUseCase: the interactor layer to call the get get category types functionality
     - Parameter getSucategoryTypesUseCase: the interactor layer to call the get get subcategory types functionality
     */
    init(createRecipeUseCase: CreateRecipeProtocol, getDiffiultTypesUseCase: GetDifficultTypesProtocol, getIngredientTypesUseCase: GetIngredientTypesProtocol, getCategoryTypesUseCase: GetCategoryTypesProtocol, getSucategoryTypesUseCase: GetSubcategoryTypesProtocol) {
        self.createRecipeUseCase = createRecipeUseCase
        self.getDifficultTypesUseCase = getDiffiultTypesUseCase
        self.getIngredientTypesUseCase = getIngredientTypesUseCase
        self.getCategoryTypesUseCase = getCategoryTypesUseCase
        self.getSubcategoryTypesUseCase = getSucategoryTypesUseCase
        
    }

    
    // MARK: - Logic
    
    /**
     Call the get difficults, ingredient types, categories and subcategories uses cases to display the information to the user. If it succeeds, the presenter sets the UIViewController to the "dataReady" state. If it does not succeed, the presenter tells the UIViewController that an error must be displayed
     */
    func getRecipesTypesData() {
        self.currentViewState = NewRecipeViewState.loading
        self.newRecipeViewState.onNext(self.currentViewState)
                
        unsubscribeActiveObservables()
        
        getDifficultTypesUseCase.getDifficultTypes()
            .subscribe(
                onNext: { data in
                    self.difficults.removeAll()
                    self.difficults.append(contentsOf: data.difficultTypes)
                },
                onError: { error in
                    let nsError = error as NSError
                    
                    if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                        self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                    } else if nsError.code == Constants.Network.TimeoutErrorCode {
                        self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                    } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                        self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                    } else {
                        self.displayError(with: UIMessages.errorGetDifficultDataTitle, and: UIMessages.errorGetDifficultDataTMessage)
                    }
                },
                onCompleted: {
                    self.getIngredientTypesUseCase.getIngredientTypes()
                        .subscribe(
                            onNext: { data in
                                self.ingredientTypes.removeAll()
                                self.ingredientTypes.append(contentsOf: data.ingredientTypes)
                            },
                            onError: { error in
                                let nsError = error as NSError
                                
                                if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                                    self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                                } else if nsError.code == Constants.Network.TimeoutErrorCode {
                                    self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                                } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                                    self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                                } else {
                                    self.displayError(with: UIMessages.errorGetIngredientsDataTitle, and: UIMessages.errorGetIngredientsDataTMessage)
                                }
                            },
                            onCompleted: {
                                self.getCategoryTypesUseCase.getCategoryTypes()
                                    .subscribe(
                                        onNext: { data in
                                            self.categories.removeAll()
                                            self.categories.append(contentsOf: data.categoryTypes)
                                        },
                                        onError: { error in
                                            let nsError = error as NSError
                                            
                                            if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                                                self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                                            } else if nsError.code == Constants.Network.TimeoutErrorCode {
                                                self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                                            } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                                                self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                                            } else {
                                                self.displayError(with: UIMessages.errorGetCategoryDataTitle, and: UIMessages.errorGetCategoryDataTMessage)
                                            }
                                        },
                                        onCompleted: {
                                            self.getSubcategoryTypesUseCase.getSubcategoryTypes()
                                                .subscribe(
                                                    onNext: { data in
                                                        self.subcategories.removeAll()
                                                        self.subcategories.append(contentsOf: data.subcategoryTypes)
                                                    },
                                                    onError: { error in
                                                        let nsError = error as NSError
                                                        
                                                        if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                                                            self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                                                        } else if nsError.code == Constants.Network.TimeoutErrorCode {
                                                            self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                                                        } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                                                            self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                                                        } else {
                                                            self.displayError(with: UIMessages.errorGetSubcategoryDataTitle, and: UIMessages.errorGetSubcategoryDataTMessage)
                                                        }
                                                    },
                                                    onCompleted: {
                                                        self.currentViewState = NewRecipeViewState.dataReady(difficultTypes: self.difficults, ingredientTypes: self.ingredientTypes, categoryTypes: self.categories, subcategoryTypes: self.subcategories)
                                                        self.newRecipeViewState.onNext(self.currentViewState)
                                                    }
                                                ).disposed(by: self.disposeBag)
                                        }
                                    ).disposed(by: self.disposeBag)
                            }
                        )
                        .disposed(by: self.disposeBag)
                }
            )
            .disposed(by: disposeBag)
    }
    
    /**
     Call the create recipe use case to create a new recipe.
     - Parameter recipe: recipe to be stored in the system
     */
    func createRecipe(recipe: Recipe) {
        
        self.currentViewState = NewRecipeViewState.loading
        self.newRecipeViewState.onNext(self.currentViewState)
        
        createRecipeUseCase.createRecipe(username: UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.usernameKey) ?? "", recipe: recipe)
            .subscribe { completable in
                switch completable {
                case .completed:
                    #if DEBUG
                    print("createRecipe completed successfully")
                    #endif

                    self.currentViewState = NewRecipeViewState.createdNewRecipe
                    self.newRecipeViewState.onNext(self.currentViewState)

                case .error(let error):
                    let nsError = error as NSError
                    #if DEBUG
                    print("createRecipe completed with an error: \(error.localizedDescription)")
                    #endif
                    if nsError.code == Constants.Network.NoInternetConnection || nsError.code == Constants.Network.WifiNotWorking {
                        self.displayError(with: UIMessages.errorNoConnectionTitle, and: UIMessages.errorNoConnection)
                    } else if nsError.code == Constants.Network.TimeoutErrorCode {
                        self.displayError(with: UIMessages.errorTimeoutTitle, and: UIMessages.errorTimeout)
                    } else if error.localizedDescription.range(of: Constants.Network.InternalServerErrorCode) != nil {
                        self.displayError(with: UIMessages.errorServerTitle, and: UIMessages.errorServerMessage)
                    } else {
                        self.displayError(with: UIMessages.errorCreateNewRecipeTitle, and: UIMessages.errorCreateNewRecipeMessage)
                    }
                }
            }
            .disposed(by: disposeBag)
    }
    
    // MARK: - Auxiliary
    
    /**
     Set the UIViewController to error state by displaying an error alert
     - Parameter title: the title for the error alert
     - Parameter message: the message to be displayed inside the error alert
     */
    func displayError(with title: String, and message: String) {
        self.currentViewState = NewRecipeViewState.error(title: title, message: message)
        self.newRecipeViewState.onNext(self.currentViewState)
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
    

