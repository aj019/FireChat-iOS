//
//  LoginController.swift
//  FireChat
//
//  Created by Anuj Gupta on 05/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit

class LoginController: UIViewController {

    let inputview: UIView = {
    
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    
    }()
    
    let registerButton : UIButton = {
        
       let button = UIButton()
        button.backgroundColor = UIColor(r: 50, g: 80, b: 150)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let nameTF : UITextField = {
       
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    
    let nameSperatorView : UIView = {
       
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        return seperator
        
    }()
    
    let emailTF : UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
        
    }()
    let emailSperatorView : UIView = {
        
        let seperator = UIView()
        seperator.translatesAutoresizingMaskIntoConstraints = false
        seperator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        return seperator
        
    }()
    
    let PassTF : UITextField = {
        
        let tf = UITextField()
        tf.placeholder = "Password"
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        view.addSubview(inputview)
        view.addSubview(registerButton)
        
        setupInputConstraints()
        setupRegisterButtonConstraints()
        
        
    }
    
    func setupInputConstraints() {
        // need x ,y , width,height
        inputview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputview.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputview.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        inputview.addSubview(nameTF)
        inputview.addSubview(nameSperatorView)
        inputview.addSubview(emailTF)
        inputview.addSubview(emailSperatorView)
        inputview.addSubview(PassTF)
        
        // Name Textfield Constraints
        nameTF.leftAnchor.constraint(equalTo: inputview.leftAnchor, constant: 12).isActive = true
        nameTF.topAnchor.constraint(equalTo: inputview.topAnchor).isActive = true
        nameTF.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        nameTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: 1/3).isActive = true
        
        // Name Seperator Constraints
        nameSperatorView.leftAnchor.constraint(equalTo: inputview.leftAnchor).isActive = true
        nameSperatorView.topAnchor.constraint(equalTo: nameTF.bottomAnchor).isActive = true
        nameSperatorView.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        nameSperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Email Textfield Constraints
        emailTF.leftAnchor.constraint(equalTo: inputview.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: nameSperatorView.bottomAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        emailTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: 1/3).isActive = true
        
        // Email Seperator Constraints
        emailSperatorView.leftAnchor.constraint(equalTo: inputview.leftAnchor).isActive = true
        emailSperatorView.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        emailSperatorView.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        emailSperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Pass Textfield Constraints
        PassTF.leftAnchor.constraint(equalTo: inputview.leftAnchor, constant: 12).isActive = true
        PassTF.topAnchor.constraint(equalTo: emailSperatorView.bottomAnchor).isActive = true
        PassTF.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        PassTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: 1/3).isActive = true
        
        
    }
    
    func setupRegisterButtonConstraints(){
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputview.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    
}

extension UIColor{
    
    convenience init(r: CGFloat,g: CGFloat,b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
}