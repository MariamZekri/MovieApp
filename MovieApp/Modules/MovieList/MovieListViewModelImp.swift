//
//  MovieListViewModelImp.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation
import Moya

class MovieListViewModelImp : MovieListViewModel{
   
    var movieList: [ModelTVShow] = []
    var errorDescription: String?
    let endPointTVshowsProvider = MoyaProvider<MovieServices>()

    var updatedModelTVList: Dynamic<Bool>
    
    // to init the VM
    init() {
        self.movieList = [ModelTVShow]()
        self.errorDescription = ""
        self.updatedModelTVList = Dynamic(false)
    }
    
    func getMovieList(page: String) {
      
        endPointTVshowsProvider.request(.TVList) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let response):
                do {
                    let modelTVList = try response.map(ModelTVList.self)
                    guard var tvResult = modelTVList.results  else { return }
                    tvResult.sort { $0.voteAverage ?? 0 > $1.voteAverage ?? 0}
                    self.movieList = tvResult
                    self.updatedModelTVList.value = true
                } catch let error {
                    print("Error in Mapping----->\(error.localizedDescription)")
                    self.errorDescription? = error.localizedDescription
                    self.updatedModelTVList.value = false
                }
            case .failure(let error):
                print("Error in Api---->\(error.localizedDescription)")
                self.errorDescription? = error.localizedDescription
                self.updatedModelTVList.value = false
            }
        }

    }
    




}
