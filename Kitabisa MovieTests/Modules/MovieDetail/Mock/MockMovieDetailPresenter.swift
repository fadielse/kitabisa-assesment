//
//  MockMovieDetailPresenter.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 24/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON
@testable import Kitabisa_Movie

class MockMovieDetailPresenter: MovieDetailPresenter {
    
    var expectationForSuccessRequest: XCTestExpectation?
    var expectationForErrorRequest: XCTestExpectation?
    
    required init(view: MovieDetailView) {
        super.init(view: view)
    }
    
    override func getMovieDetail(withMovieId movieId: Int) {
        if let file = Bundle(for: type(of: self)).url(forResource: "200_movieDetail", withExtension: "json") {
            let data = try! Data(contentsOf: file)
            let dataJson = try! JSON(data: data)
            let mockMovieDetail = MockMovieDetail(json: dataJson)
            if let detail = mockMovieDetail {
                self.movieDetail = detail
                movieDetail = detail
                self.showGetMovieDetailSuccess(withMovieDetail: detail)
            } else {
                self.showGetMovieDetailFailed(withMessage: "Failed to Parse json.")
                XCTFail("Failed to Parse json.")
            }
        } else {
            XCTFail("Cannot read json file")
        }
    }
    
    override func addMovieToFavorite() {
        super.addMovieToFavorite()
    }
}

extension MockMovieDetailPresenter: MovieDetailView {
    func setupView() {
        
    }
    
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showGetMovieDetailSuccess(withMovieDetail movieDetail: MovieDetail) {
        guard let expectation = self.expectationForSuccessRequest else {
            return
        }
        
        expectation.fulfill()
    }
    
    func showGetMovieDetailFailed(withMessage message: String) {
        guard let expectation = self.expectationForErrorRequest else {
            return
        }
        
        if message.isEmpty == true {
            XCTFail("movieList not valid. \nExpectation : \(expectation.description)")
        } else {
            expectation.fulfill()
        }
    }
    
    func updateButtonFavorite() {
        
    }
}
