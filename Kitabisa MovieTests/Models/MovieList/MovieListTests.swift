//
//  MovieListTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 24/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Kitabisa_Movie

// MARK: - Test Setup

class MovieListTests: XCTestCase {
    
    override func setUp() {
        self.continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func createMockMovieList() -> MockMovieList? {
        let filename: String = "200_upcoming"
        let fileExtension: String = "json"
        guard let mockMovieList = MockMovieList(json: build(withFilename: filename, withExtension: fileExtension)) else {
            XCTFail("Cannot read file \(filename).\(fileExtension)")
            return nil
        }
        return mockMovieList
    }
    
    func build(withFilename filename: String, withExtension fileExtension: String = "json") -> JSON? {
        if let file = Bundle(for: type(of: self)).url(forResource: filename, withExtension: fileExtension) {
            let data = try! Data(contentsOf: file)
            let dataJson = try! JSON(data: data)
            return dataJson
        }
        return nil
    }
}

// MARK: - Test Data Members

extension MovieListTests {
    
    func testInit_validJson() {
        let movieListModel = createMockMovieList()
        XCTAssertNotNil(movieListModel)
    }
    
    func testInit_InvalidJson() {
        let movieListModel = MovieList(json: nil)
        XCTAssertNil(movieListModel)
    }
    
    func testPage_isNotNil() {
        let movieListModel = createMockMovieList()
        XCTAssertNotNil(movieListModel?.page, "movieListModel.page must not nil")
    }
    
    func testTotalResults_isNotNil() {
        let movieListModel = createMockMovieList()
        XCTAssertNotNil(movieListModel?.totalResults, "movieListModel.totalResults must not nil")
    }
    
    func testTotalPages_isNotNil() {
        let movieListModel = createMockMovieList()
        XCTAssertNotNil(movieListModel?.totalPages, "movieListModel.totalPages must not nil")
    }
}

// MARK: - Test Methods

extension MovieListTests {
    
    // TODO: Create test case for each function model
}
