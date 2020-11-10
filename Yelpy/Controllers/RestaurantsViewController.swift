//
//  ViewController.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 Haruna. All rights reserved.
//

import UIKit
import AlamofireImage
import Lottie
import SkeletonView

class RestaurantsViewController: UIViewController{
    
    // ––––– TODO: Add storyboard Items (i.e. tableView + Cell + configurations for Cell + cell outlets)
    // ––––– TODO: Next, place TableView outlet here
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // –––––– TODO: Initialize restaurantsArray
    var restaurantsArray: [Restaurant] = []
    var animationView: AnimationView!
    var filteredResturants: [Restaurant] = []
    var refresh = true
    
    // ––––– TODO: Add tableView datasource + delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()

        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.rowHeight = 150
        
        getApiData()
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(self.stopAnimation), userInfo: nil, repeats: true)

    }
    
  
    
    // (completionRestaurants) in = func (completionRestaurants) {}
    // ––––– TODO: Get data from API helper and retrieve restaurants
    func getApiData() {
        API.getRestaurants() { (completionRestaurants) in
            guard let completionRestaurants = completionRestaurants else {
                return
            }
            self.restaurantsArray = completionRestaurants
            self.filteredResturants = completionRestaurants
            self.tableView.reloadData()
        }
    }
    
   
    
 

}

extension RestaurantsViewController: UISearchBarDelegate  {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty {
            filteredResturants = restaurantsArray.filter({ (r: Restaurant) -> Bool in
                return r.name.lowercased().contains(searchText.lowercased())
            })
        } else {
            filteredResturants = restaurantsArray
        }
        tableView.reloadData()
    }
    
    // cancelling out of search and hiding keyboard
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        self.searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false // remove cancel button
        searchBar.text = "" // reset search text
        searchBar.resignFirstResponder() // remove keyboarad
        filteredResturants = restaurantsArray
        tableView.reloadData()
    }
}


extension RestaurantsViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RestaurantCell"
    }
    
    func startAnimation() {
        animationView = .init(name: "4762-food-carousel")
        animationView.frame = CGRect(x: view.frame.width / 3, y: view.frame.height / 3, width: 100, height: 100)
        animationView.contentMode = .scaleAspectFit
        view.addSubview(animationView)
       
        animationView.loopMode = .loop   // set loop
        animationView.animationSpeed = 10 // larger number = fast
        animationView.play()
        
        view.showGradientSkeleton()
        
       
       
    }
    @objc func stopAnimation() {
       
        animationView.stop()
        view.hideSkeleton()
        view.subviews.last?.removeFromSuperview()
        view.hideSkeleton()
        refresh = false
    }
    
}


// ––––– TODO: Create tableView Extension and TableView Functionality
extension RestaurantsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    // how many rows?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredResturants.count
    }
    
    // cell height
//   func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//         return 150
//   }
    
    // What type of cell am i?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell") as! RestaurantCell
        
        // [Pizza hut, Dominos]
        // Get individual restaurant
//        let restaurant = restaurantsArray[indexPath.row]
        
        cell.r = filteredResturants[indexPath.row]
        if self.refresh {
            cell.showAnimatedSkeleton()
        } else {
            cell.hideSkeleton()
        }
        return cell
  
        // use timer to skeleton
//        cell.showSkeleton()
//        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) {(timer) in
//            cell.stopSkeletonAnimation()
//            cell.hideSkeleton()
//        }
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         let cell = sender as! UITableViewCell
         if let indexPath = tableView.indexPath(for: cell) {
             let r = filteredResturants[indexPath.row]
             let detailVC = segue.destination as! DetailsViewController
             detailVC.r = r
         }
     }
     

   
      
    

    
}

