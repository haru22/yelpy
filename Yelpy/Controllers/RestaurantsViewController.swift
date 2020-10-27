//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 Haruna. All rights reserved.
//

import UIKit
import AlamofireImage

class RestaurantsViewController: UIViewController {
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var tableView: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [Restaurant] = []
    
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        getApiData()

    }
    
    // (completionRestaurants) in = func (completionRestaurants) {}
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getApiData() {
        API.getRestaurants() { (completionRestaurants) in
            guard let completionRestaurants = completionRestaurants else {
                return
            }
            self.restaurantsArray = completionRestaurants
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexPath = tableView.indexPath(for: cell) {
            let r = restaurantsArray[indexPath.row]
            let detailVC = segue.destination as! DetailsViewController
            detailVC.r = r
        }
    }

}

// ––––– TODO: Create tableView Extension and TableView Functionality
extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    // how many rows?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsArray.count
    }
    
    // What type of cell am i?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        // [Pizza hut, Dominos]
        // Get individual restaurant
        let restaurant = restaurantsArray[indexPath.row]
        
        cell.r = restaurant
        return cell
    }
    
}

