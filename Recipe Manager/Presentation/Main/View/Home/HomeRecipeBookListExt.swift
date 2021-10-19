//
//  HomeRecipeBookListExt.swift
//  Recipe Manager
//


import Foundation
import UIKit

/**
 Extension of HomeVC for its tableView
 */
extension HomeVC: UITableViewDelegate, UITableViewDataSource, RecipeActionsProtocol {
    
    /**
     Configure the cell that will be displayed
    */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipe") as! CustomRecipeCell
        
        cell.idCell = indexPath.row
        
        cell.title.text =  recipes[indexPath.row].name
        cell.categoryValue.text = recipes[indexPath.row].category
        cell.durationValue.text = String(recipes[indexPath.row].duration)
        cell.difficultValue.text = recipes[indexPath.row].difficult
        
        cell.recipeActionsDelegate = self
        
        return cell
    }
    
    /**
     - Returns: number of rows
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    /**
     Removes the recipe from the system
     - Parameter name: name of the recipe to be removed
     */
    func removeRecipe(name: String) {
        presenter.removeRecipe(name: name)
    }
    
    /**
    Shows the recipe details view
     - Parameter name: name of the recipe to check its details
     */
    func showDetails(name: String) {
        let recipeSelected = recipes.filter { $0.name == name}.first!
        
        var subcategoriesString = ""
        for subcategory in recipeSelected.subcategories {
            subcategoriesString.append(subcategory.name + ", ")
        }
        subcategoriesString.removeLast(2)
        
        var ingredientsString = ""
        var calories = 0.0
        for ingredient in recipeSelected.ingredients {
            ingredientsString.append(ingredient.name + ", ")
            calories += ingredient.calories
        }
        ingredientsString.removeLast(2)
        
        titleDetails.text = recipeSelected.name
        categoryDetails.text = recipeSelected.category
        subcategoriesDetails.text = subcategoriesString
        ingredientDetails.text = ingredientsString
        descriptionDetails.text = recipeSelected.description
        caloriesDetails.text = String(calories)
        durationDetails.text = String(recipeSelected.duration)
        difficultDetails.text = recipeSelected.difficult

        detailsScrollView.isHidden = false
        recipeBookList.isHidden = true
    }
    
}
