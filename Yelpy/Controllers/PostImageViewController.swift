//
//  PostImageViewController.swift
//  Yelpy
//
//  Created by Haruna Yamakawa on 12/11/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit

// create protocol for PostImageViewControllerDelegate
protocol PostImageViewControllerDelegate: class {
    func imageSelected(controller: PostImageViewController, image: UIImage)
}

class PostImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var imageView: UIImageView!
    
    weak var delegate: PostImageViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tapImage()
        navigationController?.navigationBar.isHidden = true
    }
    @IBAction func tapImage() {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        present(picker, animated: true, completion: nil)
    }
    

    @IBAction func onPost(_ sender: Any) {
        performSegue(withIdentifier: "unwindToDetail", sender: self)
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
