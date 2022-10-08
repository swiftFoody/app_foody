//
//  Categorie.swift
//  foody
//
//  Created by Ah lucie nous gênes 🍄 on 30/09/2022.
//

import Foundation

class Categorie { //tags/list
    
    let name : String
    let display_name : String
    let type : String
    let id : Int
    
    
    init(name: String,display_name: String, type: String, id: Int) {
        self.name = name
        self.display_name = display_name
        self.type = type
        self.id = id
    }
    
}
