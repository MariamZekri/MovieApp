//
//  MovieListViewModel.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation

protocol MovieListViewModel{
    
    
    var movieList: [ModelTVShow] { get }
    
    var errorDescription: String? { get }
    // the dynamic flag to fire the listener
    var updatedModelTVList: Dynamic <Bool> {get}
    // ---------------Functions----------------
    func getMovieList(page: String)
    
   

}

