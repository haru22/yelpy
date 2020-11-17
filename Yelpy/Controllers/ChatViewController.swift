//
//  ChatViewController.swift
//  Yelpy
//
//  Created by Haruna Yamakawa on 11/15/20.
//  Copyright © 2020 memo. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    // array for message
    var messages: [PFObject] = []
    
    // create message object
    let chatMessage = PFObject(className: "Message")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        // retrieve message every 5 seconds
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(self.retrieveChatMessage), userInfo: nil, repeats: true)
        
    }
    @objc func retrieveChatMessage() {
        let query = PFQuery(className: "Message")
        query.addDescendingOrder("createdAt") // newer message is on top
        query.limit = 20
        query.includeKey("user")
        query.findObjectsInBackground { (messages, error) in
            if let messages = messages {
                self.messages = messages
                self.tableView.reloadData()
            } else {
                print(error?.localizedDescription ?? "Some other error occurerd")
            }
        }
    }
    @IBAction func onSendMessage(_ sender: Any) {
        if !messageTextField.text!.isEmpty {
            chatMessage["text"] = messageTextField.text ?? ""
            chatMessage["user"] = PFUser.current()
            self.messageTextField.text = "" // clear the text field
            chatMessage.saveInBackground { (success, error) in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("message saved")
                }
            }
        } else {
            print("empty message")
        }
    }
    
    @IBAction func onLogout(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name("logout"), object: nil)
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

extension ChatViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCellTableViewCell
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        
        // set the username
        if let user = message["user"] as? PFUser {
            cell.usernameLabel.text = user.username
        } else {
            cell.usernameLabel.text = "?"
        }
        
                // BONUS: ADD avatarImage TO CELL STORYBOARD AND CONNECT TO ChatCell
        //        let baseURL = "https://api.adorable.io/avatars/"
        //        let imageSize = 20
        //        let avatarURL = URL(string: baseURL+"\(imageSize)/\(identifier).png")
        //        cell.avatarImage.af_setImage(withURL: avatarURL!)
        //        cell.avatarImage.layer.cornerRadius = cell.avatarImage.frame.height / 2
        //        cell.avatarImage.clipsToBounds = true
        return cell
    }
}
