//
//  HomePresenterTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
@testable import Kitabisa_Movie

class HomePresenterTests: XCTestCase {
    
    // MARK: Data members
    
    var presenter: HomePresenter?
    var mockPresenter: MockHomePresenter?
    
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
    
    func createPresenter() -> HomePresenter {
        let view = HomeViewControllerTests.createViewController()
        let presenter = HomePresenter(view: view!)
        return presenter
    }
    
    func createMock(withPresenter presenter: HomePresenter?) -> MockHomePresenter {
        let view = HomeViewControllerTests.createViewController()
        let mockPresenter = MockHomePresenter(view: view!)
        return mockPresenter
    }
}

extension HomePresenterTests {
    
    func testGetMovieList_popularMovies_hasValidResponse() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Read data from JSON")
        mockPresenter?.getMovieList(withSelectedCategory: .popular)
    }
    
    func testGetMovieList_upcomingMovies_hasValidResponse() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Read data from JSON")
        mockPresenter?.getMovieList(withSelectedCategory: .upcoming)
    }
    
    func testGetMovieList_topRatedMovies_hasValidResponse() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Read data from JSON")
        mockPresenter?.getMovieList(withSelectedCategory: .topRated)
    }
    
    func testGetMovieList_nowPlayingMovies_hasValidResponse() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Read data from JSON")
        mockPresenter?.getMovieList(withSelectedCategory: .nowPlaying)
    }
    
    func testShowGetMovieListFailed_isValidMessage() {
        mockPresenter?.expectationForSuccessRequest = XCTestExpectation(description: "Show Error Message")
        mockPresenter?.showGetMovieListFailed(withMessage: "Error message")
    }
    
    func testGetList_popular_isNotEmpty() {
        mockPresenter?.getMovieList(withSelectedCategory: .popular)
        let movieList = mockPresenter?.getList()
        XCTAssertTrue(movieList?.count ?? 0 > 0, "List is Empty")
    }
    
    func testGetList_upcoming_isNotEmpty() {
        mockPresenter?.getMovieList(withSelectedCategory: .upcoming)
        let movieList = mockPresenter?.getList()
        XCTAssertTrue(movieList?.count ?? 0 > 0, "List is Empty")
    }
    
    func testGetList_topRated_isNotEmpty() {
        mockPresenter?.getMovieList(withSelectedCategory: .topRated)
        let movieList = mockPresenter?.getList()
        XCTAssertTrue(movieList?.count ?? 0 > 0, "List is Empty")
    }
    
    func testGetList_nowPlaying_isNotEmpty() {
        mockPresenter?.getMovieList(withSelectedCategory: .nowPlaying)
        let movieList = mockPresenter?.getList()
        XCTAssertTrue(movieList?.count ?? 0 > 0, "List is Empty")
    }
}
