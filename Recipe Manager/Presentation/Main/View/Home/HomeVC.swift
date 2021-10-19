//
//  HomeVC.swift
//  Recipe Manager
//


import Foundation
import UIKit
import RxSwift
import SVProgressHUD

class HomeVC: UIViewController {
    
    // MARK: - Properties & Initialization
    
    @IBOutlet weak var recipeBookList: UITableView!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var detailsScrollView: UIScrollView!
    @IBOutlet weak var homeViewBottom: NSLayoutConstraint!
    @IBOutlet weak var titleDetails: UILabel!
    @IBOutlet weak var categoryDetailsTitle: UILabel!
    @IBOutlet weak var categoryDetails: UILabel!
    @IBOutlet weak var subcategoriesDetailsTitle: UILabel!
    @IBOutlet weak var subcategoriesDetails: UILabel!
    @IBOutlet weak var ingredientsDetailsTitle: UILabel!
    @IBOutlet weak var ingredientDetails: UILabel!
    @IBOutlet weak var descriptionDetailsTitle: UILabel!
    @IBOutlet weak var descriptionDetails: UILabel!
    @IBOutlet weak var caloriesDetailsTitle: UILabel!
    @IBOutlet weak var caloriesDetails: UILabel!
    @IBOutlet weak var durationDetailsTitle: UILabel!
    @IBOutlet weak var durationDetails: UILabel!
    @IBOutlet weak var difficultDetailsTitle: UILabel!
    @IBOutlet weak var difficultDetails: UILabel!
    
    public var presenter: HomePresenter!
    private let disposeBag = DisposeBag()
    
    var recipes = [Recipe]()
    
    /**
    Lifecycle method called when the object is initializing
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipeBookList.contentInset = UIEdgeInsets(top: CGFloat(0),
                                             left: CGFloat(0),
                                             bottom: CGFloat(Constants.MoveView.viewBehindTabBar),
                                             right: CGFloat(0))
        recipeBookList.estimatedRowHeight = 0
        recipeBookList.delegate = self
        recipeBookList.dataSource = self
        recipeBookList.separatorStyle = .none
        recipeBookList.rowHeight = UITableView.automaticDimension
        recipeBookList.estimatedRowHeight = 150
        
        detailsScrollView.contentInset = UIEdgeInsets(top: CGFloat(0),
                                                left: CGFloat(0),
                                                bottom: CGFloat(Constants.MoveView.viewBehindTabBar),
                                                right: CGFloat(0))
        
        detailsView.setupCardView()
    }
    
    /**
    Lifecycle method called when the view is going to be displayed
    */
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setShadowToTabBar()
        
        homeViewBottom.constant = -Constants.MoveView.viewBehindTabBar
        
        hideDetailsAction(self)
        
        setupViewStateObserver()
        presenter.getRecipesBook()
    }
    
    
    // MARK: - UI Logic (Presenter -> UIViewController)
    
    /**
     This UIViewController subscribes to the homeViewStateObservable to get the current view state and display it
     */
    func setupViewStateObserver() {
        presenter.homeViewStateObservable
            .subscribe(
                onNext: { [unowned self] viewState in
                    DispatchQueue.main.async {
                        switch (viewState) {
                        case .loading:
                            self.displayLoadingView()
                        case .displayRecipes(let recipes):
                            self.recipes.removeAll()
                            self.recipes.append(contentsOf: recipes)
                            self.displayRecipes()
                        case .removedRecipe:
                            SVProgressHUD.dismiss()
                            self.presenter.getRecipesBook()
                        case .error(let title, let message):
                            self.displayError(with: title, and: message)
                        }
                    }
            })
            .disposed(by: disposeBag)
    }
    
    /**
     Let the user know that something is loading in the app
     */
    func displayLoadingView() {
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setBackgroundColor(Colors.mainBlue)
        SVProgressHUD.setForegroundColor(UIColor.white)
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.show()
    }
    
    /**
     Display all the recipes of the user
    */
    func displayRecipes() {
        SVProgressHUD.dismiss()
        
        if (recipes.isEmpty) {
            recipeBookList.isHidden = true
        } else {
            recipeBookList.isHidden = false
        }
    
        recipeBookList.reloadData()
        recipeBookList.fadeAnimation(duration: 0.4)
        
    }
    
    /**
     Let the user know that an error has ocurred during the course of an operation
     - Parameter title: title for error message
     - Parameter message: error message inside the view
     */
    func displayError(with title: String, and message: String) {
        recipeBookList.reloadData()
        #if DEBUG
            print("ERROR: \(message)")
        #endif
        SVProgressHUD.dismiss()
        AlertsManager.alert(caller: self, message: message, title: title) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    /**
    Hide recipe details view
     */
    @IBAction func hideDetailsAction(_ sender: Any) {
        detailsScrollView.isHidden = true
        recipeBookList.isHidden = false
    }
}
