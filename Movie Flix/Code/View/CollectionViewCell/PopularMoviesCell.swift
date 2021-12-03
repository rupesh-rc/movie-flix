//
//  PopularMoviesCell.swift
//  Movie Flix
//
//  Created by Rupesh on 01/12/21.
//

import UIKit

class PopularMoviesCell: UICollectionViewCell {
    
    static let id = "PopularMoviesCell"
    
    let imageView : LazyImageView = {
        let imageView = LazyImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.roundedCorner()
        return imageView
    }()
    
    let btnDelete : UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "close"), for: .normal)
        btn.tintColor = .white
        return btn
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.addSubview(imageView)
        contentView.addSubview(btnDelete)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
        btnDelete.frame = CGRect(x: contentView.frame.width - 40, y: 10, width: 30, height: 30)
        
    }
    
    static func nib() -> UINib {
        return UINib(nibName: PopularMoviesCell.id, bundle: nil)
    }
    
    func setupData(for movie: NowPlayingList) {
        
        let url = URL(string:"https://image.tmdb.org/t/p/original"+movie.backdropPath!)
        self.imageView.setImage(fromURL: url!, placeHolderImage: "brewApps.png")
        
    }
    
}
