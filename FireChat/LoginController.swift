//
//  LoginController.swift
//  FireChat
//
//  Created by Anuj Gupta on 05/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import UIKit
import Firebase

class LoginController: UIViewController {

    let ref = FIRDatabase.database().reference(fromURL: "https://firechat-1ef78.firebaseio.com/")
    lazy var profileImageView : UIImageView = {
       
        let imageV = UIImageView()
        imageV.image = UIImage(named: "winter")
        imageV.translatesAutoresizingMaskIntoConstraints = false
        imageV.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleSelectProfilePicture)))
        imageV.isUserInteractionEnabled = true
        return imageV
        
    }()
    
    
        
    let loginRegisterSegmentedControl : UISegmentedControl = {
       
        let sc = UISegmentedControl(items:["Login","Register"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor.white
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(handleSegmentControl), for: .valueChanged)
        return sc
        
    }()
    
    func handleSegmentControl(){
    
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        
        registerButton.setTitle(title, for: .normal)
        
        inputViewHeightAnchor?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 80:150
        
        nameTFHeightAnchor?.isActive = false
        nameTFHeightAnchor = nameTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0:1/3)
        nameTFHeightAnchor?.isActive = true
        nameTF.isHidden = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? true:false
        

        emailTFHeightAnchor?.isActive = false
        emailTFHeightAnchor = emailTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2:1/3)
        emailTFHeightAnchor?.isActive = true
        
        passTFHeightAnchor?.isActive = false
        passTFHeightAnchor = PassTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1/2:1/3)
        passTFHeightAnchor?.isActive = true
        
    }
    
    let inputview: UIView = {
    
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    
    }()
    
    lazy var registerButton : UIButton = {
        
       let button = UIButton()
        button.backgroundColor = UIColor(r: 50, g: 80, b: 150)
        button.setTitle("Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        return button
    }()
    
    
    func handleLoginRegister(){
        loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? handleLogin():handleRegister()
    }
    
    func handleLogin(){
        
        guard let email = emailTF.text,let passwd = PassTF.text,let name = nameTF.text else{
            print("Form is not valid")
            return
        }
        
        FIRAuth.auth()?.signIn(withEmail: email, password: passwd, completion: { (user, error) in
            if error != nil{
                print(error)
            }
            // Successfully login
            self.dismiss(animated: true, completion: {
                print("Done")
            })
            
        })
    }
    
    //handle register event
    
        
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
        view.addSubview(profileImageView)
        view.addSubview(loginRegisterSegmentedControl)
        
        setupInputConstraints()
        setupRegisterButtonConstraints()
        setupProfileImage()
        setupSegmentedControl()
        
        
    }
    
    var inputViewHeightAnchor : NSLayoutConstraint?
    var nameTFHeightAnchor :NSLayoutConstraint?
    var emailTFHeightAnchor : NSLayoutConstraint?
    var passTFHeightAnchor : NSLayoutConstraint?
    
    func setupInputConstraints() {
        // need x ,y , width,height
        inputview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputview.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputview.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputViewHeightAnchor = inputview.heightAnchor.constraint(equalToConstant: 150)
        inputViewHeightAnchor?.isActive = true
        
        
        inputview.addSubview(nameTF)
        inputview.addSubview(nameSperatorView)
        inputview.addSubview(emailTF)
        inputview.addSubview(emailSperatorView)
        inputview.addSubview(PassTF)
        
        // Name Textfield Constraints
        nameTF.leftAnchor.constraint(equalTo: inputview.leftAnchor, constant: 12).isActive = true
        nameTF.topAnchor.constraint(equalTo: inputview.topAnchor).isActive = true
        nameTF.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        nameTFHeightAnchor = nameTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: 1/3)
        nameTFHeightAnchor?.isActive = true
        
        // Name Seperator Constraints
        nameSperatorView.leftAnchor.constraint(equalTo: inputview.leftAnchor).isActive = true
        nameSperatorView.topAnchor.constraint(equalTo: nameTF.bottomAnchor).isActive = true
        nameSperatorView.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        nameSperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Email Textfield Constraints
        emailTF.leftAnchor.constraint(equalTo: inputview.leftAnchor, constant: 12).isActive = true
        emailTF.topAnchor.constraint(equalTo: nameSperatorView.bottomAnchor).isActive = true
        emailTF.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        emailTFHeightAnchor = emailTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: 1/3)
        emailTFHeightAnchor?.isActive = true
        
        // Email Seperator Constraints
        emailSperatorView.leftAnchor.constraint(equalTo: inputview.leftAnchor).isActive = true
        emailSperatorView.topAnchor.constraint(equalTo: emailTF.bottomAnchor).isActive = true
        emailSperatorView.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        emailSperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Pass Textfield Constraints
        PassTF.leftAnchor.constraint(equalTo: inputview.leftAnchor, constant: 12).isActive = true
        PassTF.topAnchor.constraint(equalTo: emailSperatorView.bottomAnchor).isActive = true
        PassTF.widthAnchor.constraint(equalTo: inputview.widthAnchor).isActive = true
        passTFHeightAnchor = PassTF.heightAnchor.constraint(equalTo: inputview.heightAnchor, multiplier: 1/3)
        passTFHeightAnchor?.isActive = true
        
        
        
    }
    
    func setupRegisterButtonConstraints(){
        
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.topAnchor.constraint(equalTo: inputview.bottomAnchor, constant: 12).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
    }
    
    func setupProfileImage(){
        
        profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImageView.bottomAnchor.constraint(equalTo: loginRegisterSegmentedControl.topAnchor, constant: -12).isActive = true
        profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        profileImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
    }
    
    func setupSegmentedControl(){
        
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputview.topAnchor, constant: -24).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}

extension UIColor{
    
    convenience init(r: CGFloat,g: CGFloat,b: CGFloat){
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    
    
    
}
