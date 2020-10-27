//
//  DetailsViewController.swift
//  Yelpy
//
//  Created by Haruna Yamakawa on 10/27/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantName: UILabel!
    
    var r: Restaurant!
    override func viewDidLoad() {
        super.viewDidLoad()
        restaurantName.text = r.name
        restaurantImage.af.setImage(withURL: r.imageURL!)

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
