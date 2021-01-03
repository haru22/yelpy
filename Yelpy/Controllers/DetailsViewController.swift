//
//  DetailsViewController.swift
//  Yelpy
//
//  Created by Haruna Yamakawa on 10/27/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import MapKit
import AlamofireImage

class DetailsViewController: UIViewController, MKMapViewDelegate, PostImageViewControllerDelegate {

    
    @IBOutlet weak var restaurantImage: UIImageView!
    @IBOutlet weak var restaurantNameLabel: UILabel!
    @IBOutlet weak var starImage: UIImageView!
    @IBOutlet weak var reviewCount: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    var annotationView: MKAnnotationView!
    
    // initialize restaurant variables
    var r: Restaurant!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        restaurantName.text = r.name
//        restaurantImage.af.setImage(withURL: r.imageURL!)
        configureOutlet()
        mapView.delegate = self

    }
    // add image to mapview annotation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toPostImageVC" {
            let postImageVC = segue.destination as! PostImageViewController
            postImageVC.delegate = self
        }
    }
    

    // configure outlet
    func configureOutlet() {
        restaurantNameLabel.text = r.name
        reviewCount.text = String(r.review)
        starImage.image = Stars.dict[r.rating]!
        restaurantImage.af.setImage(withURL: r.imageURL!)
        
        // Add tint opacity to image to make text stand out
        let tintView = UIView()
        tintView.backgroundColor = UIColor(white: 0, alpha: 0.3)
        tintView.frame = CGRect(x: 0, y: 0, width: restaurantImage.frame.width, height: restaurantImage.frame.height)
        restaurantImage.addSubview(tintView)
        
        // get longitude and latitude from coordinates property
        let latitude = r.coordinates["latitude"]!
        let longitude = r.coordinates["longitude"]!
        
        print(latitude,longitude)
        
        //initialize coordinate point for restaurant
        let locationCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees.init(latitude), CLLocationDegrees.init(longitude))
        // initialize region object using restaurants' coordinates
        let restanrantRegion = MKCoordinateRegion(center: locationCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        // set region in mapView to be that of restaurants
        mapView.setRegion(restanrantRegion, animated: true)
        // instantiate annotation object to show pin on map
        let annotation = MKPointAnnotation()
        // set annotation's properties
        annotation.coordinate = locationCoordinate
        annotation.title = r.name
        // drop pin on map using restaurant's coordinates
        mapView.addAnnotation(annotation)
    }
    
    // configure annotation view using protocol method
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let reuseID = "myAnnotationView"
        annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseID)
        annotationView.canShowCallout = true
        
        let annotationViewButton = UIButton(frame: CGRect(x:0, y:0, width: 50, height: 50))
        annotationViewButton.setImage(UIImage(named: "camera"), for: .normal)
        
        annotationView.leftCalloutAccessoryView = annotationViewButton
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView,
                 calloutAccessoryControlTapped control: UIControl) {
        // perform segue to postimageVC
        self.performSegue(withIdentifier: "toPostImageVC", sender: nil)
    }
    
    
    // unwind segue after finished uploading images
    @IBAction func unwind(_ seg: UIStoryboardSegue) {
        
    }
    
    func imageSelected(controller: PostImageViewController, image: UIImage) {
        // info button to annotation view
        let annotationViewButton = UIButton(frame: CGRect(x:0, y:0, width: 50, height: 50))
        annotationViewButton.setImage(image, for: .normal)
        annotationView.leftCalloutAccessoryView = annotationViewButton 
    }
}
