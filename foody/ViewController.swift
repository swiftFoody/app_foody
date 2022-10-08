//
//  ViewController.swift
//  foody
//
//  Created by Sylvain Huck on 30/09/2022.
//

import UIKit
import Alamofire
import SwiftyJSON
import PromiseKit
import Foundation

class ViewController: UIViewController{
    
    var filteredData: [ListRecipe]?
    var nameSearch : String = ""
    var data: [ListRecipe] = []
    var dataTemp : Array<String> = []
    
    @IBOutlet weak var tabSearch: UITableView!
    @IBOutlet var image: UIImageView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad()
    {
        
        super.viewDidLoad()
        self.tabSearch.delegate = self
        self.tabSearch.dataSource = self
        self.image.image = UIImage(named: "recipe.jpg")

        
        FoodApi.getFood(q: self.nameSearch).done { foodResponse in // : String
            self.data = foodResponse
        }
        //self.searchBar.delegate = self
        //FoodApi.getFoodTEST(q:"re")
    }
    
    func refreshRecipeList()
    {
        self.data.removeAll()
        FoodApi.getFood(q: self.nameSearch).done { foodResponse in // : String
            self.data = foodResponse
        }
    }

}
extension ViewController: UITableViewDataSource, UITableViewDelegate,UISearchBarDelegate
{
    func numberOfSections(in tabSearch: UITableView) -> Int
    {
        return 1
    }
    
    func tableView(_ tabSearch: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.filteredData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("tape sur ligne: \(indexPath.row)  section: \(indexPath.section)")
        performSegue(withIdentifier: "searchToRecipe", sender: filteredData?[indexPath.row].id)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "searchToRecipe"
        {

            let categorie = sender as? Int
            //print(categorie)

            if let destination = segue.destination as? RecipeViewController
            {
                destination.id = categorie ?? 0
            }
        }
     }
    
    func tableView(_ tabSearch: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")

        
        cell.textLabel?.text = filteredData?[indexPath.row].name
        cell.backgroundColor = UIColor(named:"cTableView");
        cell.layer.cornerRadius = 20
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        
        filteredData = []
        
       if searchText == ""
        {
           filteredData = self.data
        }
        else{
            
           for recipe in self.data
            {
                
               if recipe.name.lowercased().contains(searchText.lowercased()){
                    
                    filteredData?.append(recipe)
                    
                }
                
            }
        }
        nameSearch = searchText
        refreshRecipeList()
        self.tabSearch.reloadData()
        print(searchText)
        
        
    }
}


