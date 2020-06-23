//
//  MyFavoritePresenterTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
@testable import Kitabisa_Movie

class MyFavoritePresenterTests: XCTestCase {
    
    // MARK: Data members
    
    var presenter: MyFavoritePresenter?
    var mockPresenter: MockMyFavoritePresenter?
    
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
    
    func createPresenter() -> MyFavoritePresenter {
        let view = MyFavoriteViewControllerTests.createViewController()
        let presenter = MyFavoritePresenter(view: view!)
        return presenter
    }
    
    func createMock(withPresenter presenter: MyFavoritePresenter?) -> MockMyFavoritePresenter {
        let view = MyFavoriteViewControllerTests.createViewController()
        let mockPresenter = MockMyFavoritePresenter(view: view!)
        return mockPresenter
    }
}

extension MyFavoritePresenterTests {
    
    func testGetFavoriteMovies_hasValidResponse() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Load data from UserDefault")
        mockPresenter?.getFavoriteMovies()
    }
    
    func testShowGetFavoriteMovieSuccess_hasValidResponse() {
        mockPresenter?.getFavoriteMovies()
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Load data from UserDefault")
        mockPresenter?.showGetFavoriteMoviesSuccess()
    }
    
    func testShowGetFavoriteMovieFailed_isValidMessage() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Show Error Message")
        mockPresenter?.showGetFavoriteMoviesFailed(withMessage: "Error message")
    }
    
    func testGetList_isNotEmpty() {
        mockPresenter?.getFavoriteMovies()
        let movieList = mockPresenter?.getList()
        XCTAssertTrue(movieList?.count ?? 0 > 0, "List is Empty")
    }
}
