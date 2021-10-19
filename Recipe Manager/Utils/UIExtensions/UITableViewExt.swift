//
//  UITableViewExt.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 UITableViewExt
 
 UITableView extension
 */
extension UITableView {
    
    /**
     Adds fade animation to the table view cell loading
     - Parameter duration: duration of the animation in seconds
     */
    func fadeAnimation(duration: Double) {
        
        for (index, cell) in self.visibleCells.enumerated() {
            let animationDelay: TimeInterval = duration/Double(visibleCells.count)*Double(index)
            
            cell.alpha = 0.0
            UIView.animate(withDuration: duration, delay: animationDelay, options: .curveEaseInOut, animations: {
                cell.alpha = 1.0
            })
        }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + DispatchTimeInterval.milliseconds(Int(duration*1000))) {
        }
    }
}
