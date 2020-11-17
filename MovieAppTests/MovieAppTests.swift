//
//  MovieAppTests.swift
//  MovieAppTests
//
//  Created by Mariam Abdelhamid on 11/15/20.
//  Copyright © 2020 Movie. All rights reserved.
//

import XCTest
import Moya
@testable import MovieApp

class MovieAppTests: XCTestCase {
    
    var manager: MoyaProvider<MovieServices>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        manager = MoyaProvider<MovieServices>()
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        manager = nil
        super.tearDown()
    }
    
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
    private func testFetchShowsList() {
        manager.request(.TVList(page: 1)) { [weak self] result in
            
            switch result {
            case .success(let response):
                do {
                    let modelTVList = try response.map(ModelTVList.self)
                    guard var tvResult = modelTVList.results  else { return }
                    tvResult.sort { $0.voteAverage ?? 0 > $1.voteAverage ?? 0}
                    
                    XCTAssertNotEqual(tvResult.count, 0, "decoded model count equal 0")
                    
                    XCTAssertNotNil(tvResult.first?.id, "decoded model first item id equal nil")
                    
                } catch let error {
                    print("Error in Mapping----->\(error.localizedDescription)")
                    XCTFail(error.localizedDescription)
                }
            case .failure(let error):
                print("Error in Api----->\(error.localizedDescription)")
                XCTFail(error.localizedDescription)
                
            }
        }
        waitForExpectations(timeout: 10) { (error) in
            if let error = error {
                XCTFail(error.localizedDescription)
            }
        }
        
    }
}
