//
//  MovieModel.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation

struct ModelTVList: Codable {
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [ModelTVShow]?

    enum CodingKeys: String, CodingKey {
        case page = "page"
        case totalResults = "total_results"
        case totalPages = "total_pages"
        case results = "results"
    }
}

// MARK: - Result
struct ModelTVShow: Codable {
    let originalName: String?
    let genreIDS: [Int]?
    let name: String?
    let popularity: Double?
    let originCountry: [String]?
    let voteCount: Int?
    let firstAirDate: String?
    let backdropPath: String?
    let originalLanguage: String?
    let id: Int?
    let voteAverage: Double?
    let overview: String?
    let posterPath: String?

    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case genreIDS = "genre_ids"
        case name = "name"
        case popularity = "popularity"
        case originCountry = "origin_country"
        case voteCount = "vote_count"
        case firstAirDate = "first_air_date"
        case backdropPath = "backdrop_path"
        case originalLanguage = "original_language"
        case id = "id"
        case voteAverage = "vote_average"
        case overview = "overview"
        case posterPath = "poster_path"
    }
}

