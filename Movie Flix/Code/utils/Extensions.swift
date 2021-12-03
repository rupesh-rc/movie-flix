//
//  Extensions.swift
//  Movie Flix
//
//  Created by Rupesh on 01/12/21.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    
    func asNib() -> UINib {
        return UINib(nibName: "\(Self.self)", bundle: nil)
    }
    
}

extension UIViewController {
    
    func getPosterUrl(urlString : String) -> URL {
        let url = "https://image.tmdb.org/t/p/w342" 
        return URL(string: "\(url+urlString)")!
    }
    
    func getFullImageUrl(urlString : String) -> URL {
        let url = "https://image.tmdb.org/t/p/original"
        return URL(string: "\(url+urlString)")!
    }
    
}


extension  UIImageView {
    func roundedCorner() {
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
    }
}
