//
//  RestaurantCell.swift
//  Yelpy
//
//  Created by Memo on 10/17/20.
//  Copyright © 2020 Haruna. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {
    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var r: Restaurant! {
           didSet {
               restaurantNameLabel.text = r.name
               categoryLabel.text = r.mainCategory
               phoneLabel.text = r.phone
               reviewLabel.text = String(r.review)
               
               starImage.image = Stars.dict[r.rating]!
               restaurantImage.af.setImage(withURL: r.imageURL!)
       
           }
       }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
