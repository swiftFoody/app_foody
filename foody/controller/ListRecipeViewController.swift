//
//  ListRecipeViewController.swift
//  foody
//
//  Created by Ah lucie nous gênes 🍄 on 01/10/2022.
//

import Foundation
import UIKit

class ListRecipeTableViewController: UITableViewController {
    
    
    var nameCategorie : String = ""
    
    var data: [ListRecipe] = []

    
    override func viewDidLoad() {
        //ViewController.swapMode()
        self.tableView.reloadData()
        print(nameCategorie)
        refreshRecipeList()
        
        //self.title = "Category"
        
        //overrideUserInterfaceStyle = .dark
    }
    
    func refreshRecipeList() {
        self.data.removeAll()
        FoodApi.getFood(tag: nameCategorie).done { foodResponse in // : String
            self.data = foodResponse
            self.tableView.reloadData()
        }
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        super.numberOfSections(in: tableView)
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("tape sur ligne: \(indexPath.row)  section: \(indexPath.section)")
        performSegue(withIdentifier: "segueToRecipeList", sender: data[indexPath.row].id)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "recetteCell")
        
        cell.textLabel?.text = data[indexPath.row].name
        cell.backgroundColor = UIColor(named:"cTableView");
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueToRecipeList"
        {

            let categorie = sender as? Int
            //print(categorie)

            if let destination = segue.destination as? RecipeViewController
            {
                destination.id = categorie ?? 0
            }

        }
     }

    
}

/*
class receipeListController: UITableViewController {
    var recettes: [Receipe] = [Receipe]()
}
 */
