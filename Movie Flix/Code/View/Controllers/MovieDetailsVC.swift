//
//  MovieDetailsVC.swift
//  Movie Flix
//
//  Created by Rupesh on 02/12/21.
//

import Foundation
import UIKit
import WebKit

class MovieDetailsVC: UIViewController {
    
    @IBOutlet weak var trailerWebView : WKWebView!
    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblDescription : UILabel!
    @IBOutlet weak var lblReleaseDate : UILabel!
    @IBOutlet weak var posterImageView : LazyImageView!
    @IBOutlet weak var ratingStackView : StarRatingStckView!
    
    let movieViewModel = MovieViewModel()
    
    var movie : NowPlayingList!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadMovieDetails()
    }
    
    //MARK: FUNCTIONS
    
    func loadMovieDetails() {
        
        if movie.voteAverage! > 7 {
            loadMovieTrailer(self.movie.id!)
            self.posterImageView.isHidden = true
        } else {
            setupImageView()
        }
        
        self.lblTitle.text = movie.title
        self.lblDescription.text = movie.overview
        self.lblReleaseDate.text = "Release Date: \(movie.releaseDate!)"
        self.ratingStackView.setStarsRating(rating: Int(movie.voteAverage!/2))
    }
    
    func setupImageView() {
        //self.posterImageView.roundedCorner()
        self.posterImageView.setImage(fromURL: getFullImageUrl(urlString: movie.backdropPath!), placeHolderImage: "brewApps.png")
    }
    
    func loadMovieTrailer(_ movieId : Int) {
        movieViewModel.getMoviesTrailerList(movieID: movieId) { trailers in
            let url = URL(string: "https://www.youtube.com/embed/\(trailers[0].key!)")!
            DispatchQueue.main.async {
                self.trailerWebView.load(URLRequest(url: url))
            }
        }
    }
}
