//
//  ViewController.swift
//  FireChat
//
//  Created by Anuj Gupta on 05/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import Firebase

class MessageController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ref = FIRDatabase.database().reference(fromURL: "https://firechat-1ef78.firebaseio.com/")
//        ref.updateChildValues(["some":"456"])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New", style: .plain, target: self, action: #selector(newMessage))
        
        checkIfUserLoggedIn()
    
    }
    
    func newMessage(){
        
        let newMessageController = NewMessageController()
        let navController = UINavigationController(rootViewController: newMessageController)
        present(navController, animated: true, completion: nil)
        
    }
    
    
    func checkIfUserLoggedIn(){
        
        if FIRAuth.auth()?.currentUser?.uid == nil{
            
            perform(#selector(handleLogout), with: self, afterDelay: 0)
            
        }else{
            
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dict = snapshot.value as? [String : AnyObject]{
                    self.navigationItem.title = dict["name"] as! String
                }
                
            })
        }

    }

    
    func handleLogout() {
        
        do{
           try FIRAuth.auth()?.signOut()
        } catch{
            print(error)
        }
        
        let lc = LoginController()
        self.present(lc, animated: true, completion: nil)
        
        
    }
   
}

