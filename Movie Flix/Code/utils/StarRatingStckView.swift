//
//  StarRatingStckView.swift
//  Movie Flix
//
//  Created by Rupesh on 03/12/21.
//

import Foundation
import UIKit

class StarRatingStckView: UIStackView {
    var starsRating = 0
    var starsEmptyPicName = "star" // change it to your empty star picture name
    var starsFilledPicName = "star.fill" // change it to your filled star picture name
    override func draw(_ rect: CGRect) {
        let starButtons = self.subviews.filter{$0 is UIButton}
        var starTag = 1
        for button in starButtons {
            if let button = button as? UIButton{
                button.setImage(UIImage(systemName: starsEmptyPicName), for: .normal)
                button.addTarget(self, action: #selector(self.pressed(sender:)), for: .touchUpInside)
                button.tag = starTag
                starTag = starTag + 1
            }
        }
        setStarsRating(rating:starsRating)
    }
    func setStarsRating(rating:Int){
        self.starsRating = rating
        let stackSubViews = self.subviews.filter{$0 is UIButton}
        for subView in stackSubViews {
            if let button = subView as? UIButton{
                if button.tag > starsRating {
                    button.setImage(UIImage(systemName: starsEmptyPicName), for: .normal)
                }else{
                    button.setImage(UIImage(systemName: starsFilledPicName), for: .normal)
                }
            }
        }
    }
    @objc func pressed(sender: UIButton) {
        // setStarsRating(rating: sender.tag)
    }
}
