//
//  Recipe.swift
//  foody
//
//  Created by Ah lucie nous gênes 🍄 on 30/09/2022.
//

import Foundation

class Recipe{ // recipes/get-more-info
    
    
    let name : String
    let thumbnail_url : String
    let instructions : Array<String>
    
    init(name: String,thumbnail_url :String, instruction : Array<String>) { //, thumbnail_url: String, display_text: String, postion: Int, start_time: Int, end_time: Int, temparature: Int
        self.name = name
        self.thumbnail_url = thumbnail_url
        self.instructions = instruction

    }
    
    
    
    
    
}
