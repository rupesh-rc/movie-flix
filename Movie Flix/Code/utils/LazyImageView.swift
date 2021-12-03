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
    
    func setImage(fromURL imageURL: URL, placeHolderImage: String) {
        self.image = UIImage(named: placeHolderImage)
        
        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject) {
            debugPrint("Cached Image for ::\(imageURL)")
            self.image = cachedImage
            return
        }
        
        DispatchQueue.global().async {
            [weak self] in
            
            if let imageData = try? Data(contentsOf: imageURL) {
                debugPrint("Image Downloaded from ::\(imageURL)")
                if let image = UIImage(data: imageData) {
                    DispatchQueue.main.async {
                        self!.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                    }
                }
            }
        }
    }
}
