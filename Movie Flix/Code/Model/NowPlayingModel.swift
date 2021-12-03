//
//  NowPlayingModel.swift
//  Movie Flix
//
//  Created by Rupesh on 01/12/21.
//

import Foundation


struct NowPlayingResponse: Codable {
    let dates: Dates?
    let page: Int?
    let results: [NowPlayingList]?
    let totalPages: Int?
    let totalResults: Int?
    
}


struct Dates: Codable {
    let maximum: String?
    let minimum: String?
}


struct NowPlayingList: Codable {
    let adult: Bool?
    let backdropPath: String?
    let genreIDS: [Int]?
    let id: Int?
    let originalTitle: String?
    let overview: String?
    let popularity: Double?
    let posterPath: String?
    let releaseDate: String?
    let title: String?
    let video: Bool?
    let voteAverage: Double?
    let voteCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

