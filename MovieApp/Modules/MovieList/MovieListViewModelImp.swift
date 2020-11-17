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
    func getMovieList() {
        endPointTVshowsProvider.request(.TVList(page: page)) { [weak self] result in
                   guard let self = self else { return }
                   switch result {
                   case .success(let response):
            
                       do {
                           let modelTVList = try response.map(ModelTVList.self)
                           guard let tvResult = modelTVList.results  else { return }
                           self.movieList.append(contentsOf: tvResult)
                           self.page += self.page
                           self.movieList.sort { $0.voteAverage ?? 0 > $1.voteAverage ?? 0}
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
    

    
   // MARK: - Paging
   var page : Int = 1

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
    




}
