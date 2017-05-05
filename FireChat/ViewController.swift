//
//  ViewController.swift
//  FireChat
//
//  Created by Anuj Gupta on 05/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
    }

    
    func handleLogout() {
        let lc = LoginController()
        self.present(lc, animated: true, completion: nil)
        
        
    }
   
}

