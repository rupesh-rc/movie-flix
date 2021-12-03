//
//  MovieViewModel.swift
//  Movie Flix
//
//  Created by Rupesh on 01/12/21.
//

import Foundation

class MovieViewModel {
    

    //MARK:GET NOW PLAYING MOVIES LIST
    
    func getNowPlayingMoviesList(completion : @escaping ([NowPlayingList]) -> ()) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            if let _error = error {
                print("ERROR ::",_error.localizedDescription)
            }
            
            if let _data = data {
                do {
                    let result = try JSONDecoder().decode(NowPlayingResponse.self, from: _data)
                    completion(result.results!)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
    //MARK: GET MOVIE TRAILER LIST
    func getMoviesTrailerList(movieID: Int, completion : @escaping ([MovieTrilerList]) -> ()) {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")
        
        URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if let _error = error {
                print("ERROR ::",_error.localizedDescription)
            }
            
            if let _data = data {
                do {
                    let result = try JSONDecoder().decode(MovieTrilerResponse.self, from: _data)
                    completion(result.results!)
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
    }
    
}
