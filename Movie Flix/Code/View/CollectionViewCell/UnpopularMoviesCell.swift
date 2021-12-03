//
//  UnpopularMoviesCell.swift
//  Movie Flix
//
//  Created by Rupesh on 01/12/21.
//

import UIKit

class UnpopularMoviesCell: UICollectionViewCell {
    
    static let id = "UnpopularMoviesCell"
    
    //MARK: PROPERTIES
    @IBOutlet weak var posterImageView : LazyImageView!
    @IBOutlet weak var lblMovieTitle : UILabel!
    @IBOutlet weak var lblMovieDescription : UILabel!
    @IBOutlet weak var btnDelete : UIButton!
    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.posterImageView.roundedCorner()
    }
    
    
    
    //MARK: FUNCTIONS
    func setupData(for movie: NowPlayingList) {
        let url = URL(string:"https://image.tmdb.org/t/p/w342"+movie.posterPath!)
        self.posterImageView.setImage(fromURL: url!, placeHolderImage: "brewApps.png")
        self.lblMovieTitle.text = movie.title
        self.lblMovieDescription.text = movie.overview
    }
    
}
