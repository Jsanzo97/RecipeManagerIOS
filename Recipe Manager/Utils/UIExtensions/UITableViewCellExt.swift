//
//  UITableViewCellExt.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 UITableViewCellExt
 
 UITableViewCell extension
 */
extension UITableViewCell {
    
    /**
     Visual configuration of the tableView cells
     */
    func setupCardView(view: UIView) {
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = false
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 2.0
    }
}

extension UIView {
    
    /**
     Visual configuration of the tableView cells
     */
    func setupCardView() {
        layer.cornerRadius = 8
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2.0
    }
}
