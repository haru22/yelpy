//
//  SceneDelegate.swift
//  Yelpy
//
//  Created by Memo on 5/21/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import Parse

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if PFUser.current() != nil {
            login()
        }
        // add event listener for when user logs in
        NotificationCenter.default.addObserver(forName: NSNotification.Name("login"), object: nil, queue: OperationQueue.main) { (Notification) in
            print("Login notification received")
            self.login()
        }
        
        // add event listener for when user logs out
        NotificationCenter.default.addObserver(forName: NSNotification.Name("logout"), object: nil, queue: OperationQueue.main) { (Notification) in
                print("Log out notification received")
                self.logout()
            }

        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func login() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "TabBar")
        
    }
    
    func logout() {
        PFUser.logOutInBackground { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful logout")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                self.window?.rootViewController = storyboard.instantiateViewController(withIdentifier: "Login")
            }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

