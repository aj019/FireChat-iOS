//
//  NewMessageControllerTableViewController.swift
//  FireChat
//
//  Created by Anuj Gupta on 12/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import Firebase

class NewMessageController: UITableViewController {

    
    let cellid = "Cell_Id"
    var users = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancel))
        
        tableView.register(Usercell.self, forCellReuseIdentifier: cellid)
        
        fetchUsers()
        
       }
    
    
    func fetchUsers(){
        
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            if let dict = snapshot.value as? [String : AnyObject] {
                
                let user = User()
                
                user.name = dict["name"] as! String
                user.email = dict["email"] as! String
                
                self.users.append(user)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
            
        }) { (error) in
            print(error)
        }
        
    }
    
    func cancel(){
        dismiss(animated: true, completion: nil)
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //This ia a hack we need to use deque our cells
        //let cell = UITableViewCell(style: .subtitle, reuseIdentifier: cellid)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath)
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        return cell
        
    }
  
}

class Usercell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
