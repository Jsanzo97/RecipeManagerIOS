//
//  CustomRecipeCell.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 Represents a cell (Recipe) on the list of trips (RecipeBook) and show usefull information about it
*/
class CustomRecipeCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var categoryTitle: UILabel!
    @IBOutlet weak var categoryValue: UILabel!
    @IBOutlet weak var durationTitle: UILabel!
    @IBOutlet weak var durationValue: UILabel!
    @IBOutlet weak var difficultTitle: UILabel!
    @IBOutlet weak var difficultValue: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    @IBOutlet weak var recipeView: UIView!
    
    weak var recipeActionsDelegate: RecipeActionsProtocol?
    
    /// Identifier for the cell
    var idCell = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // On this devices the font size should be smaller or the text will not be displayed correctly
        if UIDevice.current.type.rawValue == DeviceModel.iPhoneSE.rawValue ||
            UIDevice.current.type.rawValue == DeviceModel.iPhone5S.rawValue {
            title.font = .boldSystemFont(ofSize: Constants.font.fontSizeForSmallDevice)
            categoryTitle.font = .boldSystemFont(ofSize: Constants.font.fontSizeForSmallDevice)
            categoryValue.font = .systemFont(ofSize: Constants.font.fontSizeForSmallDevice)
            durationTitle.font = .boldSystemFont(ofSize: Constants.font.fontSizeForSmallDevice)
            durationValue.font = .systemFont(ofSize: Constants.font.fontSizeForSmallDevice)
            difficultTitle.font = .boldSystemFont(ofSize: Constants.font.fontSizeForSmallDevice)
            difficultValue.font = .systemFont(ofSize: Constants.font.fontSizeForSmallDevice)
            
        }
        
        // Set visual configurations
        setupCardView(view: recipeView)
    }
    
    
    @IBAction func showDetails(_ sender: Any) {
        recipeActionsDelegate?.showDetails(name: title.text ?? "")
    }
    
    @IBAction func removeRecipe(_ sender: Any) {
        recipeActionsDelegate?.removeRecipe(name: title.text ?? "")
    }
}
