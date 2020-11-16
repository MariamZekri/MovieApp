//
//  MovieServices.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation

class MovieServices : NSObject {
    
    private let apiKey = "3b13831a9cc291e8995ab77ede7acac2"
    private let baseUrl = "https://api.themoviedb.org/3/movie"
    
    
    private let jsonDecoder: JSONDecoder = {
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
}
