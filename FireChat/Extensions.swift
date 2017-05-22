//
//  Extensions.swift
//  FireChat
//
//  Created by Anuj Gupta on 22/05/17.
//  Copyright © 2017 test. All rights reserved.
//

import Foundation
import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()
extension UIImageView{
    
    
    
    func loadImageUsinCachingwithUrlString(urlString: String){
        
        let url = NSURL(string: urlString)
        let request = URLRequest(url: url! as URL)
        
        if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage{
            self.image = cachedImage
            return
        }
        
        URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
            
            
            if error != nil{
                print(error)
                return
            }
            
            DispatchQueue.main.async {
                //          cell.imageView?.image = UIImage(data: data!)
                
                let downloadedImage = UIImage(data: data!)
                
                imageCache.setObject(downloadedImage!, forKey: urlString as AnyObject)
                
                self.image = downloadedImage
            }
            
            
            
        }).resume()

        
    }
}
