//
//  Restaurant.swift
//  Yelpy
//
//  Created by Haruna Yamakawa on 10/27/20.
//  Copyright © 2020 Haruna. All rights reserved.
//

import Foundation

class Restaurant {
    var imageURL: URL?
    var name: String
    var mainCategory: String
    var phone: String
    var rating: Double
    var review: Int
    
    // refactor model
    var coordinates: [String:Double]
    
    
    
    init(dict: [String:Any]) {
        imageURL = URL(string: dict["image_url"] as! String)
        name = dict["name"] as! String
        phone = dict["display_phone"] as! String
        rating = dict["rating"] as! Double
        review = dict["review_count"] as! Int
        mainCategory = Restaurant.getMainCategory(dict: dict)
        coordinates = dict["coordinates"] as! [String:Double]

    }
    
    static func getMainCategory(dict: [String: Any])->String{
        let categoryArray = dict["categories"] as! [[String:Any]]
        return categoryArray[0]["title"] as! String
    }
}
