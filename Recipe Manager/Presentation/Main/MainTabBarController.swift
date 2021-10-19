//
//  MainTabBarController.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 Main tab bar controller of the app that it is displayed when the user log in the system. It consists of three tabBarItems:
 - New Recipe
 - Home
 - Close session
 */
class MainTabBarController: UITabBarController {
    
    // MARK: - Properties & Initialization
    
    private var bottomSelectedView: UIView!
    private static var bottomTabBar: UITabBar!
    
    /**
     Lifecycle method called when the object is initializing. Here we set up the view controllers belonging to the TabBarController.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
                
        let newRecipeStoryboard = UIStoryboard(name: Constants.Storyboard.NewRecipe, bundle: nil)
        let newRecipeViewController = newRecipeStoryboard.instantiateInitialViewController() as! UINavigationController

        let homeStoryboard = UIStoryboard(name: Constants.Storyboard.Home, bundle: nil)
        let homeViewController = homeStoryboard.instantiateInitialViewController() as! UINavigationController

        let closeStoryboard = UIStoryboard(name: Constants.Storyboard.Close, bundle: nil)
        let closeViewController = closeStoryboard.instantiateInitialViewController() as! UINavigationController

        let tabBarList = [newRecipeViewController, homeViewController, closeViewController]
        self.tabBar.tintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = Colors.white.withAlphaComponent(0.5)
        self.tabBar.isTranslucent = false
        MainTabBarController.bottomTabBar = self.tabBar
        viewControllers = tabBarList
        
    }
    
    /**
     Subviews and style configuration
    */
    override func viewDidLayoutSubviews() {
        setSemicircularStyle()
        addRoundedViewBottom(index: 1)
        UserDefaults.standard.set(NSCoder.string(for: self.tabBar.frame), forKey: Constants.UserDefaultsKeys.tabBarBounds)
    }
    
    /**
     Change the white line under item selected
    */
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == self.tabBar.items![0] {
            addRoundedViewBottom(index: 0)
        } else if item == self.tabBar.items![1] {
            addRoundedViewBottom(index: 1)
        } else if item == self.tabBar.items![2] {
            addRoundedViewBottom(index: 2)
        }
    }
    
    /**
     Add white line under item selected
     - Parameter index: number of item selected to draw the line under it
    */
    func addRoundedViewBottom (index: Int) {
        let width = self.tabBar.bounds.width / 3 - 40
        let height = Constants.tabBarSizes.bottomViewHeight
        let posX = 20 + (CGFloat(index) * (width + 40))
        var posY = self.tabBar.bounds.maxY - Constants.tabBarSizes.bottomSpace
        
        // On different devices to these, the selected item view should be more separated
        if UIDevice.current.type.rawValue != DeviceModel.iPhoneX.rawValue &&
           UIDevice.current.type.rawValue != DeviceModel.iPhoneXR.rawValue &&
           UIDevice.current.type.rawValue != DeviceModel.iPhoneXS.rawValue &&
           UIDevice.current.type.rawValue != DeviceModel.iPhoneXSMax.rawValue {
            posY = self.tabBar.bounds.maxY - Constants.tabBarSizes.bottomSpaceSmallDevice
        }
        
        if bottomSelectedView != nil {
            bottomSelectedView.removeFromSuperview()
        }
        
        bottomSelectedView = UIView(frame: CGRect(x: posX, y: posY, width: width, height: height))
        bottomSelectedView.backgroundColor = Colors.white
        bottomSelectedView.layer.cornerRadius = 10
        
        self.tabBar.insertSubview(bottomSelectedView, at: 1)
    }
    
    /**
     Set a semicicular style to tab bar
    */
    func setSemicircularStyle() {
        var frame = self.tabBar.frame
        frame.size.height = Constants.MoveView.viewBehindTabBar
        frame.origin.y = self.view.frame.size.height - Constants.MoveView.viewBehindTabBar
        self.tabBar.frame = frame
        
        var spaceToCenter = Constants.tabBarSizes.spaceToCenter
        
        // On this devices the tab bar should be smaller or it will cover too much screen
        if UIDevice.current.type.rawValue == DeviceModel.iPhone5S.rawValue ||
            UIDevice.current.type.rawValue == DeviceModel.iPhone6S.rawValue ||
            UIDevice.current.type.rawValue == DeviceModel.iPhone7.rawValue ||
            UIDevice.current.type.rawValue == DeviceModel.iPhoneSE.rawValue {
            spaceToCenter = Constants.tabBarSizes.spaceToCenterSmallDevice
        }
        
        let circlePath = UIBezierPath.init(arcCenter: CGPoint(x: self.tabBar.frame.size.width / 2,
                                                              y: self.tabBar.frame.size.height + spaceToCenter),
                                           radius: Constants.tabBarSizes.radius,
                                           startAngle: .pi,
                                           endAngle: 0,
                                           clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        self.tabBar.layer.mask = circleShape
    }
    
    static func hide() {
        bottomTabBar.isHidden = true
    }
    
    static func show() {
        bottomTabBar.isHidden = false
    }
}
