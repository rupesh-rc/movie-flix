//
//  CachedImageView.swift
//  Movie Flix
//
//  Created by Rupesh on 01/12/21.
//

import Foundation
import UIKit

class LazyImageView: UIImageView {
    
    
    
    private let imageCache = NSCache<AnyObject, UIImage>()
    
    func storeImage(urlString: String, image: UIImage) {
        let path = NSTemporaryDirectory().appending(UUID().uuidString)
        let url = URL(fileURLWithPath: path)
        
        let data = image.jpegData(compressionQuality: 1.0)
        try? data?.write(to: url)
        
        var dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String]
        if dict == nil {
            dict = [String:String]()
        }
        dict![urlString] = path
        UserDefaults.standard.setValue(dict, forKey: "ImageCache")
    }
    
    func setImage(fromURL imageURL: URL, placeHolderImage: String) {
        self.image = UIImage(named: placeHolderImage)
        
        if let dict = UserDefaults.standard.object(forKey: "ImageCache") as? [String:String] {
            if let path = dict[imageURL.absoluteString] {
                if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                    let image = UIImage(data: data)
                    self.image = image
                }
            }
        }
        
        DispatchQueue.global().async {
            [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL) {
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.sync {
                        self?.storeImage(urlString: imageURL.absoluteString, image: image)
                        self?.image = image
                    }
                }
            }
        }
    }
    
    
}


