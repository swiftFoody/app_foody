//
//  RecipeViewController.swift
//  foody
//
//  Created by Ah lucie nous gênes 🍄 on 01/10/2022.
//

import Foundation
import UIKit
import WebKit


class RecipeViewController : UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var tabIntructions: UITableView!
    @IBOutlet weak var titre: UILabel!
    
    var data: [Recipe] = []
    let cellReuseIdentifier = "step"
    var id : Int = 0

    override func viewDidLoad()
    {
        print(id)
        refreshRecipe()
        
        self.tabIntructions.delegate = self
        self.tabIntructions.dataSource = self
        //verrideUserInterfaceStyle = .dark//.light
    }
    
    func refreshRecipe()
    {
        self.data.removeAll()
        FoodApi.getRecipe(idRecipe: id).done { recipeResponse in
            self.data = recipeResponse

            self.titre.text=self.data[0].name
            
            if let url = URL(string: self.data[0].thumbnail_url), let imgData = try? Data(contentsOf: url)
            {
                let image = UIImage(data: imgData)
                self.img.image = image
            }
            
            self.tabIntructions.reloadData()
            
        }

    }
  
}
extension RecipeViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tabIntructions: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if(self.data.isEmpty == false)
        {
            return self.data[0].instructions.count
        }
        else
        {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellReuseIdentifier)
        cell.textLabel?.numberOfLines = 0//Paramètre le maximum de ligne en illimité (0)
        cell.backgroundColor = UIColor(named:"cTableView");
        cell.layer.cornerRadius = 20
        if(self.data.isEmpty == false)
        {
            //print(self.data[0].instructions[0])
            cell.textLabel?.text = self.data[0].instructions[indexPath.row]
        }
        else
        {
            cell.textLabel?.text = "Aucune instruction donnée"
        }
        
        return cell
    }
    
}

