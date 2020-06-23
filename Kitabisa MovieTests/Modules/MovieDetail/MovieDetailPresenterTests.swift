//
//  MovieDetailPresenterTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 24/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
@testable import Kitabisa_Movie

class MovieDetailPresenterTests: XCTestCase {
    
    // MARK: Data members
    
    var presenter: MovieDetailPresenter?
    var mockPresenter: MockMovieDetailPresenter?
    
    // MARK: Overrides
    
    override func setUp() {
        presenter = createPresenter()
        mockPresenter = createMock(withPresenter: presenter)
    }
    
    override func tearDown() {
        presenter = nil
        mockPresenter = nil
    }
    
    // MARK: Methods
    
    func createPresenter() -> MovieDetailPresenter {
        let view = MovieDetailViewControllerTests.createViewController()
        let presenter = MovieDetailPresenter(view: view!)
        return presenter
    }
    
    func createMock(withPresenter presenter: MovieDetailPresenter?) -> MockMovieDetailPresenter {
        let view = MovieDetailViewControllerTests.createViewController()
        let mockPresenter = MockMovieDetailPresenter(view: view!)
        return mockPresenter
    }
}

extension MovieDetailPresenterTests {
    
    func testGetMovieDetail_hasValidResponse() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Read data from JSON.")
        mockPresenter?.getMovieDetail(withMovieId: 122917)
    }
    
    func testShowGetMovieListFailed_isValidMessage() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Show Error Message.")
        mockPresenter?.showGetMovieDetailFailed(withMessage: "Error message.")
    }
}
