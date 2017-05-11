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
    
    }

    
    func handleLogout() {
        let lc = LoginController()
        self.present(lc, animated: true, completion: nil)
        
        
    }
   
}

