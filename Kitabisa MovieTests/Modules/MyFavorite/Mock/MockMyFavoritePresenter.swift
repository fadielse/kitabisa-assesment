//
//  MockMyFavoritePresenter.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import XCTest
@testable import Kitabisa_Movie

class MockMyFavoritePresenter: MyFavoritePresenter {
    
    var expectationForSuccessRequest: XCTestExpectation?
    var expectationForErrorRequest: XCTestExpectation?
    
    required init(view: MyFavoriteView) {
        super.init(view: view)
    }
    
    override func getFavoriteMovies() {
        if let favoriteList = StorageUtils.favoriteList {
            self.favoriteMovies = favoriteList
            self.showGetFavoriteMoviesSuccess()
        } else {
            self.showGetFavoriteMoviesFailed(withMessage: "Failed to get favorite movies.")
        }
    }
    
    override func getList() -> [MovieListItem] {
        return self.favoriteMovies
    }
}

extension MockMyFavoritePresenter: MyFavoriteView {
    func setupView() {
        
    }
    
    func showGetFavoriteMoviesSuccess() {
        guard let expectation = self.expectationForSuccessRequest else {
            return
        }
        
        if self.favoriteMovies.count > 0 {
            expectation.fulfill()
        } else {
            XCTFail("Favorite movies is Empty. \nExpectation : \(expectation.description)")
        }
    }
    
    func showGetFavoriteMoviesFailed(withMessage message: String) {
        guard let expectation = self.expectationForErrorRequest else {
            return
        }
        
        if message.isEmpty == true {
            XCTFail("Favorite movies not valid. \nExpectation : \(expectation.description)")
        } else {
            expectation.fulfill()
        }
    }
}
