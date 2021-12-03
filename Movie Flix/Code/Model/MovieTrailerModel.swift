//
//  MovieTrailerModel.swift
//  Movie Flix
//
//  Created by Rupesh on 01/12/21.
//

import Foundation


struct MovieTrilerResponse: Codable {
    let id: Int?
    let results: [MovieTrilerList]?
}

struct MovieTrilerList: Codable {
    let name: String?
    let key: String?
    let site: String?
    let size: Int?
    let type: String?
    let official: Bool?
    let publishedAt: String?
    let id: String?
    
}
