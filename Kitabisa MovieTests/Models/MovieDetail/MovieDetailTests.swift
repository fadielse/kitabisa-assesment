//
//  MovieDetailTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 24/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
import SwiftyJSON
@testable import Kitabisa_Movie

// MARK: - Test Setup

class MovieDetailTests: XCTestCase {
    
    override func setUp() {
        self.continueAfterFailure = false
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func createMockMovieDetail() -> MockMovieDetail? {
        let filename: String = "200_movieDetail"
        let fileExtension: String = "json"
        guard let mockMovieDetail = MockMovieDetail(json: build(withFilename: filename, withExtension: fileExtension)) else {
            XCTFail("Cannot read file \(filename).\(fileExtension)")
            return nil
        }
        return mockMovieDetail
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

extension MovieDetailTests {
    
    func testInit_validJson() {
        let movieDetail = createMockMovieDetail()
        XCTAssertNotNil(movieDetail)
    }
    
    func testInit_InvalidJson() {
        let movieDetail = MockMovieDetail(json: nil)
        XCTAssertNil(movieDetail)
    }
    
    func testTitle_isNotNil() {
        let movieDetail = createMockMovieDetail()
        XCTAssertNotNil(movieDetail?.title, "movieDetail.title should not nil.")
    }
    
    func testReleaseDate_isNotNil() {
        let movieDetail = createMockMovieDetail()
        XCTAssertNotNil(movieDetail?.releaseDate, "movieDetail.releaseDate should not nil.")
    }
    
    func testOverview_isNotNil() {
        let movieDetail = createMockMovieDetail()
        XCTAssertNotNil(movieDetail?.overview, "movieDetail.overview should not nil.")
    }
    
    func testPosterPath_isNotNil() {
        let movieDetail = createMockMovieDetail()
        XCTAssertNotNil(movieDetail?.posterPath, "movieDetail.posterPath should not nil.")
    }
}

// MARK: - Test Methods

extension MovieDetailTests {
    
    func testGetPosterPageUrl_isValidUrl() {
        let movieDetail = createMockMovieDetail()
        XCTAssertNotNil(movieDetail?.getPosterPageUrl, "Return should not nil.")
    }
    
    func testGetPosterPageUrl_isInvalidUrl() {
        let movieDetail = MockMovieDetail(json: nil)
        XCTAssertNil(movieDetail?.getPosterPageUrl, "Return should nil.")
    }
}
