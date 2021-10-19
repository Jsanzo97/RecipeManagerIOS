//
//  UIViewControllerExt.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 UIViewControllerExt
 
 UIViewController extension
 */
extension UIViewController {
    
    /**
     Slide out transition animation which takes place when the screen is switched
     - Parameter current: UIViewController calling the animation
     - Parameter new: UIViewController to be displayed after animation
     - Returns: displayed UIViewController
     */
    func animateSlideOutTransition(from current: UIViewController, to new: UIViewController, completion: (() -> Void)? = nil) -> UIViewController {
        let initialFrame = CGRect(x: -view.bounds.width, y: 0, width: view.bounds.width, height: view.bounds.height)
        current.willMove(toParent: nil)
        addChild(new)
        new.view.frame = initialFrame
        
        transition(from: current, to: new, duration: 0.75, options: [], animations: {
            new.view.frame = self.view.bounds
        }) { _ in
            current.removeFromParent()
            new.didMove(toParent: self)
            completion?()
        }
        return new
    }
    
    /**
     Fade transition animation which takes place when the screen is switched
     - Parameter current: UIViewController calling the animation
     - Parameter new: UIViewController to be displayed after animation
     - Returns: displayed UIViewController
     */
    func animateFadeTransition(from current: UIViewController, to new: UIViewController, completion: (() -> Void)? = nil) -> UIViewController {
        current.willMove(toParent: nil)
        addChild(new)
        
        transition(from: current, to: new, duration: 0.75, options: [.transitionCrossDissolve, .curveEaseOut], animations: {
        }) { _ in 
            current.removeFromParent()
            new.didMove(toParent: self)
            completion?()
        }
        return new
    }
    
    /**
     Set new color for the status bar
     - Parameter color: new color for the text of status bar
     */
    func setColorForStatusBar(color: UIColor) {
        if #available(iOS 13.0, *) {
            let statusBar1 =  UIView()
            statusBar1.frame = UIApplication.shared.keyWindow?.windowScene?.statusBarManager!.statusBarFrame as! CGRect
            statusBar1.tintColor = color

            UIApplication.shared.keyWindow?.addSubview(statusBar1)
        } else if UIApplication.shared.responds(to: Selector(("statusBar"))),
            let statusBar = UIApplication.shared.value(forKey: "statusBar") as? UIView,
            statusBar.responds(to: #selector(getter: CATextLayer.foregroundColor)) {
            statusBar.setValue(color, forKey: "foregroundColor")
        }
    }
    
    /**
     Hides the keyboard when user taps around the application
     */
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    /**
     Selector function to dismiss the keyboard
     */
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    /**
     Add a view to simulate shadow tab bar
    */
    func setShadowToTabBar() {
        let shadowOffset = CGFloat(5)
        
        let infoBounds = UserDefaults.standard.string(forKey: Constants.UserDefaultsKeys.tabBarBounds)
        var bounds = NSCoder.cgRect(for: infoBounds!)
        bounds.origin.y = self.view.bounds.maxY - shadowOffset
        
        let shadowView = UIView(frame: bounds)
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
        shadowView.layer.shadowOpacity = 0.25
        shadowView.layer.shadowRadius = 4.0
        
        var spaceToCenter = Constants.tabBarSizes.spaceToCenter
        
        // On this devices the tab bar shadow should be smaller or it will cover too much screen
        if UIDevice.current.type.rawValue == DeviceModel.iPhone5S.rawValue ||
            UIDevice.current.type.rawValue == DeviceModel.iPhone6S.rawValue ||
            UIDevice.current.type.rawValue == DeviceModel.iPhone7.rawValue ||
            UIDevice.current.type.rawValue == DeviceModel.iPhoneSE.rawValue {
            spaceToCenter = Constants.tabBarSizes.spaceToCenterSmallDevice
        }
        
        let circlePath = UIBezierPath.init(arcCenter: CGPoint(x: bounds.size.width / 2, y: bounds.size.height + spaceToCenter),
                                           radius: Constants.tabBarSizes.radius,
                                           startAngle: .pi,
                                           endAngle: 0,
                                           clockwise: true)
        let circleShape = CAShapeLayer()
        circleShape.path = circlePath.cgPath
        
        shadowView.layer.shadowPath = circlePath.cgPath
        shadowView.layer.shouldRasterize = true
        shadowView.layer.rasterizationScale = UIScreen.main.scale
        
        self.view.addSubview(shadowView)
    }
    
}
