//
//  MovieServices.swift
//  MovieApp
//
//  Created by Mariam Abdelhamid on 11/16/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import Foundation
import Moya

public enum MovieServices {
    case TVList(page: Int)
}

extension MovieServices: TargetType {
    public var baseURL: URL {
        switch self {
        case .TVList:
            return URL(string: Constants.baseURl + "3/tv/popular?api_key=\(Constants.api_key)")!
        }
        
    }
    
    public var path: String {
        return ""
    }
    
    public var method: Moya.Method {
        switch self {
        case .TVList:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    public var task: Task {
    var params: [String : Any] = ["api_key": Constants.api_key]
        
        switch self {
        case .TVList(let page):
            params["page"] = "\(page)"
          
        }
        
        return .requestParameters(parameters: params, encoding: URLEncoding.queryString)
    }
    
    public var headers: [String : String]? {
        var header = [String : String]()
        header["api_key"] = Constants.api_key
         return header
    }
    
}
