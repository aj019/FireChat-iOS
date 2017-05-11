//
//  ViewController.swift
//  FireChat
//
//  Created by Anuj Gupta on 05/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let ref = FIRDatabase.database().reference(fromURL: "https://firechat-1ef78.firebaseio.com/")
//        ref.updateChildValues(["some":"456"])
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
        
        if FIRAuth.auth()?.currentUser?.uid == nil{
            
            perform(#selector(handleLogout), with: self, afterDelay: 0)
            
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

