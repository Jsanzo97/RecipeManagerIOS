//
//  NewRecipeVC.swift
//  Recipe Manager
//


import Foundation
import UIKit
import SVProgressHUD
import RxSwift


class NewRecipeVC: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties & Initialization

    @IBOutlet weak var newRecipeView: UIView!
    @IBOutlet weak var newIngredientView: UIView!
    @IBOutlet weak var recipeTitle: UITextField!
    @IBOutlet weak var recipeCategory: UITextField!
    @IBOutlet weak var recipeSubcategory: UITextField!
    @IBOutlet weak var recipeIngredients: UITextField!
    @IBOutlet weak var recipeDescription: UITextField!
    @IBOutlet weak var ingredientName: UITextField!
    @IBOutlet weak var ingredientType: UITextField!
    @IBOutlet weak var ingredientCalories: UITextField!
    @IBOutlet weak var recipeDuration: UITextField!
    @IBOutlet weak var recipeDifficult: UITextField!
    @IBOutlet weak var addIngredient: UIButton!
    @IBOutlet weak var cancelRecipe: UIButton!
    @IBOutlet weak var acceptRecipe: UIButton!
    @IBOutlet weak var cancelIngredient: UIButton!
    @IBOutlet weak var acceptIngredient: UIButton!
    
    var typePicker: UIPickerView! = UIPickerView()
    
    private var showCategories = false
    private var showSubcategories = false
    private var showIngredientTypes = false
    private var showDifficults = false
    
    private var ingredientsAdded = [Ingredient]()

    public var presenter: NewRecipePresenter!
    private let disposeBag = DisposeBag()
    
    private var categoriesAvailable = [Category]()
    private var subcategoriesAvailable = [Subcategory]()
    private var difficultsAvailable = [Difficult]()
    private var ingredientTypesAvailable = [IngredientType]()
    
    @IBOutlet weak var backgroundBottom: NSLayoutConstraint!
    
    /**
    Lifecycle method called when the object is initializing
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        typePicker.isHidden = true
        typePicker.delegate = self
        
        recipeCategory.inputView = typePicker
        recipeSubcategory.inputView = typePicker
        recipeDifficult.inputView = typePicker
        ingredientType.inputView = typePicker
        
        recipeCategory.delegate = self
        recipeSubcategory.delegate = self
        recipeDifficult.delegate = self
        ingredientType.delegate = self
    
        setupViewStateObserver()
    }
    
    /**
    Lifecycle method called when the view is going to be displayed
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        backgroundBottom.constant = -Constants.MoveView.viewBehindTabBar
        
        newRecipeView.setupCardView()
        newIngredientView.setupCardView()
        
        presenter.getRecipesTypesData()
    }
    
    
    // MARK: - UI Logic (Presenter -> UIViewController)
    
    /**
     This UIViewController subscribes to the newRecipeViewStateObservable to get the current view state and display it
     */
    func setupViewStateObserver() {
        presenter.newRecipeViewStateObservable
            .subscribe(
                onNext: { [unowned self] viewState in
                    DispatchQueue.main.async {
                        switch (viewState) {
                        case .loading:
                            self.displayLoadingView()
                        case .dataReady(let difficultTypes, let ingredientTypes, let categoryTypes, let subcategoryTypes):
                            SVProgressHUD.dismiss()
                            self.categoriesAvailable.removeAll()
                            self.categoriesAvailable.append(contentsOf: categoryTypes)
                            self.ingredientTypesAvailable.removeAll()
                            self.ingredientTypesAvailable.append(contentsOf: ingredientTypes)
                            self.difficultsAvailable.removeAll()
                            self.difficultsAvailable.append(contentsOf: difficultTypes)
                            self.subcategoriesAvailable.removeAll()
                            self.subcategoriesAvailable.append(contentsOf: subcategoryTypes)
                        case .createdNewRecipe:
                            self.displaySuccess(with: UIMessages.successNewRecipeTitle, and: UIMessages.successNewRecipeMessage)
                            self.clearAllText()
                        case .error(let title, let message):
                            self.displayError(with: title, and: message)
                        }
                    }
            })
            .disposed(by: disposeBag)
    }
    
    
    /**
     Clear all fields
    */
    private func clearAllText() {
        recipeTitle.text = ""
        recipeDifficult.text = ""
        recipeCategory.text = ""
        recipeSubcategory.text = ""
        recipeIngredients.text = ""
        recipeDescription.text = ""
        recipeDuration.text = ""
        ingredientsAdded.removeAll()
    }
    
    /**
     Let the user know that the app is performing an operation which needs time
    */
    func displayLoadingView() {
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.setBackgroundColor(Colors.lightGrey)
        SVProgressHUD.setForegroundColor(Colors.black)
        SVProgressHUD.show()
    }
    
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
    
    /**
     Let the user know that an operation has been done successfully
     - Parameter title: title for error message
     - Parameter message: error message inside the view
     */
    func displaySuccess(with title: String, and message: String) {
        print("SUCCESS: \(message)")
        SVProgressHUD.dismiss()
        AlertsManager.alert(caller: self, message: message, title: title) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    // MARK: - UIPickerViewDelegate

    /**
     Returns the number of 'columns' to display.
    */
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    /**
     Returns the number of rows in each component
    */
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (showCategories) {
            return categoriesAvailable.count
        } else if (showSubcategories) {
            return subcategoriesAvailable.count
        } else if (showDifficults) {
            return difficultsAvailable.count
        } else if (showIngredientTypes) {
            return ingredientTypesAvailable.count
        } else {
            return 0
        }
    }

    /**
     Returns the value of each row
    */
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if (showCategories) {
            return categoriesAvailable[row].category
        } else if (showSubcategories) {
            return subcategoriesAvailable[row].name
        } else if (showDifficults) {
            return difficultsAvailable[row].difficult
        } else if (showIngredientTypes) {
            return ingredientTypesAvailable[row].ingredientType
        } else {
            return ""
        }
    }

    /**
     Assign the value selected to the correspondent textfield
    */
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if (showCategories) {
            recipeCategory.text = categoriesAvailable[row].category
        } else if (showSubcategories) {
            recipeSubcategory.text = subcategoriesAvailable[row].name
        } else if (showDifficults) {
            recipeDifficult.text = difficultsAvailable[row].difficult
        } else if (showIngredientTypes) {
            ingredientType.text = ingredientTypesAvailable[row].ingredientType
        }
        
        typePicker.isHidden = true
    }
    
    
    // MARK: - Button Actions

    /**
     Cancel the recipe creation removing all values from the textfields
    */
    @IBAction func cancelRecipeAction(_ sender: Any) {
        clearAllText()
    }
    
    /**
     Create new recipe if all fields are filled
    */
    @IBAction func acceptRecipeAction(_ sender: Any) {
        if recipeTitle.text!.isEmpty ||
            recipeDescription.text!.isEmpty ||
            recipeDuration.text!.isEmpty ||
            recipeIngredients.text!.isEmpty ||
            ingredientsAdded.isEmpty ||
            recipeCategory.text!.isEmpty ||
            recipeSubcategory.text!.isEmpty ||
            recipeDifficult.text!.isEmpty {
            displayError(with: UIMessages.emptyRecipeFieldsTitle, and: UIMessages.emptyRecipeFieldsMessage)
        } else {
            presenter.createRecipe(recipe:
                Recipe(
                    name: recipeTitle.text!,
                    description: recipeDescription.text!,
                    duration: (recipeDuration.text! as NSString).doubleValue,
                    difficult: recipeDifficult.text!,
                    ingredients: ingredientsAdded,
                    category: recipeCategory.text!,
                    subcategories: [Subcategory](arrayLiteral: Subcategory(name: recipeSubcategory.text!))
                )
            )
        }
    }
    
    /**
     Shows the create ingredient view
    */
    @IBAction func addIngredientAction(_ sender: Any) {
        newRecipeView.isHidden = true
        newIngredientView.isHidden = false
    }
    
    /**
     Hide the create ingredient view and remove all values of the ingredient textfields
    */
    @IBAction func cancelIngredientAction(_ sender: Any) {
        newIngredientView.isHidden = true
        newRecipeView.isHidden = false
        
        ingredientType.text = ""
        ingredientName.text = ""
        ingredientCalories.text = ""
    }
    
    /**
     Create new ingredient if all fields are filled
    */
    @IBAction func acceptIngredientAction(_ sender: Any) {
        if ingredientName.text!.isEmpty || ingredientCalories.text!.isEmpty || ingredientType.text!.isEmpty {
            displayError(with: UIMessages.emptyRecipeFieldsTitle, and: UIMessages.emptyRecipeFieldsMessage)
        } else {
            ingredientsAdded.append(Ingredient(name: ingredientName.text!, type: ingredientType.text!, calories: ((ingredientCalories.text!) as NSString).doubleValue))
            
            if ingredientsAdded.count == 1 {
                recipeIngredients.text?.append("\(ingredientName.text ?? "")")
            } else {
                recipeIngredients.text?.append(", \(ingredientName.text ?? "")")
            }
            
            cancelIngredientAction(sender)
        }
    }
    
    
    // MARK: - UITextFieldDelegate
    
    /**
     Asks the delegate if the text field start the prccess od edit the text
     - Parameter textField: text field that begins to be edited
     */
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch textField {
            case recipeDifficult:
                showDifficults = true
                showIngredientTypes = false
                showCategories = false
                showSubcategories = false
            case recipeCategory:
                showDifficults = false
                showIngredientTypes = false
                showCategories = true
                showSubcategories = false
            case recipeSubcategory:
                showDifficults = false
                showIngredientTypes = false
                showCategories = false
                showSubcategories = true
            case ingredientType:
                showDifficults = false
                showIngredientTypes = true
                showCategories = false
                showSubcategories = false
            default:
                showDifficults = false
                showIngredientTypes = false
                showCategories = false
                showSubcategories = false
            }
        
        typePicker.reloadAllComponents()
        typePicker.reloadInputViews()
        typePicker.isHidden = false
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
    
}
