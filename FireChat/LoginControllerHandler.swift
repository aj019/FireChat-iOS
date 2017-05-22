//
//  LoginControllerHandler.swift
//  FireChat
//
//  Created by Anuj Gupta on 13/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit
import Firebase


extension LoginController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    func handleSelectProfilePicture(){
        
        
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.allowsEditing = true
        
        present(picker, animated: true, completion: nil)
        
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        
        var selectedPickerImage : UIImage?
        
        if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            
            selectedPickerImage = originalImage
            
        }else if let edittedImage = info["UIImagePickerControllerEdittedImage"] as? UIImage{
        
            selectedPickerImage = edittedImage
        }
        
        
        if let selectedImage = selectedPickerImage{
            profileImageView.image = selectedImage
            dismiss(animated: true, completion: nil)
        }
    
    }
    
    
    func handleRegister(){
        
        
        guard let email = emailTF.text,let passwd = PassTF.text,let name = nameTF.text else{
            print("Form is not valid")
            return
        }
        
        
        FIRAuth.auth()?.createUser(withEmail: email, password: passwd, completion: { (user, err) in
            
            // If there is an error print the error
            if err != nil{
                print(err)
                return
            }
            // successfully registered
            guard let uid = user?.uid else{
                return
            }

            let imageName = UUID().uuidString
            let storage = FIRStorage.storage().reference().child("profile_images").child("\(imageName).png")
            
            if let uploadData = UIImagePNGRepresentation(self.profileImageView.image!){
                
                storage.put(uploadData, metadata: nil, completion: { (metadata, error) in
                    if error != nil{
                        print(error)
                    }
                    
                    if let profileImageUrl = metadata?.downloadURL()?.absoluteString {
                        
                        let values = ["name": name,"email": email,"profileImageUrl": profileImageUrl]
                        self.registerUserIntoDatabaseWithUID(uid: uid, values: values as [String : AnyObject])
                        print(metadata)
                    }
                    
                    
                    
                })
            }
            
            
            
        })
    }
    
    
    private func registerUserIntoDatabaseWithUID(uid: String,values: [String:AnyObject] ){
        
        
        let childref = self.ref.child("users").child(uid)
        childref.updateChildValues(values, withCompletionBlock: { (err, childref) in
            if err != nil{
                print(err)
                return
            }
            
            self.dismiss(animated: true, completion: nil)
            
        })

    }


}
