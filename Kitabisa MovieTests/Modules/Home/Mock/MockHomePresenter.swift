//
//  MockHomePresenter.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON
@testable import Kitabisa_Movie

class MockHomePresenter: HomePresenter {
    
    var expectationForSuccessRequest: XCTestExpectation?
    var expectationForErrorRequest: XCTestExpectation?
    
    required init(view: HomeView) {
        super.init(view: view)
    }
    
    override func getMovieList(withSelectedCategory selectedCategory: HomeViewController.MovieCategory) {
        let request = MovieListRequest()
        request.apiKey = AppConstant.ApiKey
        
        var jsonFile: String = "200_popular"
        
        switch selectedCategory {
        case .popular:
            jsonFile = "200_popular"
        case .upcoming:
            jsonFile = "200_upcoming"
        case .topRated:
            jsonFile = "200_topRated"
        case .nowPlaying:
            jsonFile = "200_nowPlaying"
        }
        
        if let file = Bundle(for: type(of: self)).url(forResource: jsonFile, withExtension: "json") {
            let data = try! Data(contentsOf: file)
            let dataJson = try! JSON(data: data)
            let movieList = MockMovieList(json: dataJson)
            if let movielistResult = movieList?.results {
                self.movieList = movielistResult
                self.showGetMovieListSuccess()
            } else {
                self.showGetMovieListFailed(withMessage: "Movie list is empty.")
            }
        } else {
            XCTFail("Cannot read json file")
        }
    }
    
    override func getList() -> [MovieListItem] {
        return movieList
    }
}

extension MockHomePresenter: HomeView {
    func setupView() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showGetMovieListSuccess() {
        guard let expectation = self.expectationForSuccessRequest else {
            return
        }
        
        if movieList.count > 0 {
            expectation.fulfill()
        } else {
            XCTFail("movieList is Empty. \nExpectation : \(expectation.description)")
        }
    }
    
    func showGetMovieListFailed(withMessage message: String) {
        guard let expectation = self.expectationForErrorRequest else {
            return
        }
        
        if message.isEmpty == true {
            XCTFail("movieList not valid. \nExpectation : \(expectation.description)")
        } else {
            expectation.fulfill()
        }
    }
}
