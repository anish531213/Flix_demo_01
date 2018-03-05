//
//  Movie.swift
//  Flix_demo_01
//
//  Created by Anish Adhikari on 2/27/18.
//  Copyright © 2018 Anish Adhikari. All rights reserved.
//

import Foundation

class Movie {
    var title: String!
    var posterUrl: URL?
    var backdropUrl: URL?
    var release: String!
    var id: Int!
    var overview: String!
    
    init(dictionary: [String: Any]) {
        title = dictionary["title"] as? String ?? "No title"
        overview = dictionary["overview"] as? String ?? "No Overview"
        id = dictionary["id"] as? Int
        release = dictionary["release"] as? String ?? "No release"
        
        // getting posterPath
        let baseUrlString = "https://image.tmdb.org/t/p/w500"
        let posterPath = dictionary["poster_path"] as? String
        if let posterPath = posterPath {
            let fullPosterPath = baseUrlString + posterPath
            posterUrl = URL(string: fullPosterPath)
        }
        
        // getting backDropPath
        let backdropPath = dictionary["backdrop_path"] as? String
        if let backdropPath = backdropPath {
            let fullPosterPath = baseUrlString + backdropPath
            backdropUrl = URL(string: fullPosterPath)
        }
    }
    
    class func movies(dictionaries: [[String: Any]]) -> [Movie] {
        var movies: [Movie] = []
        for dictionary in dictionaries {
            let movie = Movie(dictionary: dictionary)
            movies.append(movie)
        }
        
        return movies
    }
}
