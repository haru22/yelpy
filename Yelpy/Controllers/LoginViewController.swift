//
//  LoginViewController.swift
//  Yelpy
//
//  Created by Haruna Yamakawa on 11/15/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    func usernameAndPasswordEmpty() -> Bool {
        return usernameTextField.text!.isEmpty || passwordTextField.text!.isEmpty
    }

    @IBAction func onSignUp(_ sender: Any) {
        if (!usernameAndPasswordEmpty()) {
            // initialize a user object
            let newUser = PFUser()
            // if it's nill return
            guard let username = usernameTextField.text else {
                print("No text in text field")
                return
            }
            guard let password = passwordTextField.text else {
                return
            }
            
            newUser.username = username
            newUser.password = password
            
            // cell sign up function on the object
            newUser.signUpInBackground() { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                    self.displaySignpError(with: error)
                } else {
                    print("User \(newUser.username!) Registered successfully")
                    // post internal notification to the app to let other screens that listen for key know we signed up
                    NotificationCenter.default.post(name: NSNotification.Name("login"), object: nil)
                }
                
            }
        } else {
            displayEmptyTextError()
        }
    }
    
    @IBAction func onLogin(_ sender: Any) {
        if (!usernameAndPasswordEmpty()) {
            guard let username = usernameTextField.text else {
                return
            }
            guard let password = passwordTextField.text else {
                return
            }
            
            PFUser.logInWithUsername(inBackground: username, password: password) { (user: PFUser?, error: Error?) in
                if let error = error {
                    print("User log in failed: \(error.localizedDescription)")
                    self.displayLoginError(with: error)
                } else {
                    print("User \(username) Logged in successfully")
                    NotificationCenter.default.post(name: NSNotification.Name("login"), object: nil)
                }
            }
        } else {
            displayEmptyTextError()
        }
        
        
        
    }
    
    /** Alert Controller */
    
    func displaySignpError(with error: Error) {
        let title = "Sign up error"
        let message = "Oops! something went wrong while signing up: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default)
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true)
    }
    
    func displayEmptyTextError() {
        let title = "Error empty textfield"
        let message = "Username or Password cannot be empty)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        present(alertController,animated: true)
    }
    
    // use with for readablity
    func displayLoginError(with error: Error) {
        let title = "Login error"
        let message = "Oops! something went wrong while logging in: \(error.localizedDescription)"
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        present(alertController,animated: true)
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
