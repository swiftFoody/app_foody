//
//  randomView.swift
//  foody
//
//  Created by Ah lucie nous gênes 🍄 on 30/09/2022.
//

import Foundation
import UIKit

class CategorieTableViewController : UITableViewController {

    var data: [Categorie] = []
    

    override func viewDidLoad() {
        self.tableView.reloadData()
        self.title = "Category"
        
        refreshFoodList()
        
        //overrideUserInterfaceStyle = .dark
    }
   
    
    
    //getFoodListCategory
    func refreshFoodList() {
        self.data.removeAll()
        FoodApi.getFoodListCategory().done { foodResponse in
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
        //print( data[indexPath.row].name)
        performSegue(withIdentifier: "categoryToReceipeList", sender: data[indexPath.row].name)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "recetteCell")
        
        cell.textLabel?.text = data[indexPath.row].display_name
        cell.backgroundColor = UIColor(named:"cTableView");
        cell.layer.cornerRadius = 20
        return cell
    }
    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "categoryToReceipeList" {
     
             let categorie = sender as? String
             //print(categorie)
     
             if let destination = segue.destination as? ListRecipeTableViewController {
                 destination.nameCategorie = categorie ?? ""

             }
     
         }
     }
    
    
   /* override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "categoryToReceipeList" {
            if let destination = segue.destination as? ListCategorieTableViewController {
                destination.recettes = listOfReceipe
            }
        }
    }*/
    
}




/*
class receipeListController: UITableViewController {
    var recettes: [Receipe] = [Receipe]()
}
 */
