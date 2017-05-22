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
                
                user.name = dict["name"] as? String
                user.email = dict["email"] as? String
                user.profileImageUrl = dict["profileImageUrl"] as? String
                
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
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellid, for: indexPath) as! Usercell
        
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = "hello"
        //cell.imageView?.image = UIImage(named: "winter")
        
        if let profileImageURL = user.profileImageUrl{
            
            cell.profileImageView.loadImageUsinCachingwithUrlString(urlString: profileImageURL)
            
        }
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
  
}

class Usercell: UITableViewCell {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 56, y: textLabel!.frame.origin.y, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 56, y: detailTextLabel!.frame.origin.y, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
        
    }
    
    
    let profileImageView : UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "catchphrase")
        imageView.layer.cornerRadius = 20
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
        
        addSubview(profileImageView)
        
        //ios 9 constraints
        //width height x y
        
        profileImageView.centerXAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        profileImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
