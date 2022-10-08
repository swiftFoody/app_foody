//
//  FoodApi.swift
//  foody
//
//  Created by Ah lucie nous gênes 🍄 on 30/09/2022.
//
import Alamofire
import SwiftyJSON
import PromiseKit
import Foundation

enum Api: String {
    case apikey = "97ebb34e14msh901bf8f7147a51ap11bc9ajsnc664817c200d"
    case apiHost = "tasty.p.rapidapi.com"
}

let headers = [
    "X-RapidAPI-Key": Api.apikey.rawValue,
    "X-RapidAPI-Host": Api.apiHost.rawValue
]

class FoodApi{

    
    //tags/list (recuperation des categories = id/type/name/display_name)
    
    static func getFoodListCategory() -> Promise<[Categorie]>{
    
        var categories : [Categorie] = []

        return Promise{ seal in
        
            AF.request("https://tasty.p.rapidapi.com/tags/list", headers: HTTPHeaders(headers)).response { response in
                let json = JSON(response.data as Any)
                let categorieJSON = json["results"]//.arrayValue //["results"]
            
                 for categorie in categorieJSON {
                    categories.append(Categorie(name: categorie.1["name"].stringValue,
                                               display_name: categorie.1["display_name"].stringValue,
                                               type: categorie.1["type"].stringValue,
                                               id: categorie.1["id"].intValue)
                    )
                     //print(categorie.1["name"])
                }
                
                // on retourne le resultat de la promesse
                //print(categorieJSON[0]["name"])
                //print(json["results"][0]["name"])
                seal.fulfill(categories)
                
            }
            
        }
    }
    
    static func getFood( tag : String? = nil, q :String? = nil )  -> Promise<[ListRecipe]> //recipes/list (recuperation information complete recette )
    {
        var listRecipes : [ListRecipe] = []
        
        return Promise { seal in
            
            if(tag == nil && q == nil)
            {
                AF.request("https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=&q=", headers: HTTPHeaders(headers)).response { response in
                let json = JSON(response.data as Any)
                let listRecipeJSON = json["results"]//.arrayValue //["results"]
                //print(listRecipeJSON)
                
                 for listRecipe in listRecipeJSON {
                    listRecipes.append(ListRecipe(name: listRecipe.1["name"].stringValue,
                                               id: listRecipe.1["id"].intValue)
                    )
                     
                     //print(listRecipe.1["name"])
                }
                    //print(listRecipes)
                // on retourne le resultat de la promesse
                //print(json["results"][0]["name"])
                seal.fulfill(listRecipes)
                }
            }
            
            if let tagSafe = tag
            {
                
                AF.request("https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=\(tagSafe)", headers: HTTPHeaders(headers)).response { response in
                let json = JSON(response.data as Any)
                let listRecipeJSON = json["results"]//.arrayValue //["results"]
                //print(listRecipeJSON)
                
                 for listRecipe in listRecipeJSON {
                     //printprint(listRecipe.1)
                    listRecipes.append(ListRecipe(name: listRecipe.1["name"].stringValue,
                                               id: listRecipe.1["id"].intValue)
                    )
                     
                     //print(listRecipe.1["name"])
                }
                    //print(listRecipes)
                // on retourne le resultat de la promesse
                //print(json["results"][0]["name"])
                seal.fulfill(listRecipes)
                
                }
            }
            
            if let querySafe = q
            {
                
                AF.request("https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&q=\(querySafe)", headers: HTTPHeaders(headers)).response { response in
                let json = JSON(response.data as Any)
                let listRecipeJSON = json["results"]//.arrayValue //["results"]
                //print(listRecipeJSON)
                
                 for listRecipe in listRecipeJSON {
                     //print(listRecipe.1)
                    listRecipes.append(ListRecipe(name: listRecipe.1["name"].stringValue,
                                               id: listRecipe.1["id"].intValue)
                    )
                     
                     //print(listRecipe.1["name"])
                }
                // on retourne le resultat de la promesse
                //print(json["results"][0]["name"])
                seal.fulfill(listRecipes)
                
                }
            }
        }
    }
    
    static func getRecipe(idRecipe : Int) -> Promise<[Recipe]>{  //tags/list (recuperation des categories = id/type/name/display_name)
    
        var recipes : [Recipe] = []

        return Promise{ seal in
        
            AF.request("https://tasty.p.rapidapi.com/recipes/get-more-info?id=\(idRecipe)" , headers: HTTPHeaders(headers)).response { response in
                var tabInstruction : Array<String> = []
                let jsonRecipe = JSON(response.data as Any)

                let recipeJSON = jsonRecipe["instructions"]//.arrayValue //["results"]
            
                
                for recipe in recipeJSON
               {
                    tabInstruction.append(recipe.1["display_text"].stringValue)
               }
                
                //print(tabInstruction[0])
                // on retourne le resultat de la promesse
                //print(recipeJSON[0]["name"])
                //print(jsonRecipe["instructions"]["display_text"])
                recipes.append(Recipe(name: jsonRecipe["name"].stringValue,thumbnail_url: jsonRecipe["thumbnail_url"].stringValue,instruction : tabInstruction as! Array<String>))
                
                //print(recipes)
                seal.fulfill(recipes)
                
            }
            
        }
    }
    
}



