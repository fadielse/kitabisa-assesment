//
//  MovieDetailViewControllerTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 24/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
@testable import Kitabisa_Movie

// MARK: - Test Setup

class MovieDetailViewControllerTests: XCTestCase {
    
    // MARK: Data members
    
    var viewController: MovieDetailViewController?
    var mockViewController: MockMovieDetailViewController?
    
    // MARK: Overrides
    
    override func setUp() {
        viewController = MovieDetailViewControllerTests.createViewController()
        mockViewController = MovieDetailViewControllerTests.createMock(withViewController: viewController)
    }
    
    override func tearDown() {
        viewController = nil
        mockViewController = nil
    }
    
    // MARK: Methods
    
    static func createViewController() -> MovieDetailViewController? {
        let viewController = MovieDetailViewController.createModule()
        viewController.loadViewIfNeeded()
        return viewController
    }
    
    static func createMock(withViewController view: MovieDetailViewController?) -> MockMovieDetailViewController {
        let mockViewController = MockMovieDetailViewController(view: view)
        return mockViewController
    }
}

// MARK: - Test IBOutlets

extension MovieDetailViewControllerTests {
    
    func testHas_imageMovie() {
        XCTAssertNotNil(viewController?.imageMovie, "imageMovie is nil.")
    }
    
    func testHas_labelTitle() {
        XCTAssertNotNil(viewController?.labelTitle, "labelTitle is nil.")
    }
    
    func testHas_buttonFavorite() {
        XCTAssertNotNil(viewController?.buttonFavorite, "buttonFavorite is nil.")
    }
    
    func testHas_labelDate() {
        XCTAssertNotNil(viewController?.labelDate, "labelDate is nil.")
    }
    
    func testHas_labelOverview() {
        XCTAssertNotNil(viewController?.labelOverview, "labelOverview is nil.")
    }
}

// MARK: - Test Methods

extension MovieDetailViewControllerTests {
    
    func testUpdateButtonFavorite_isSuccessAdd() {
        viewController?.presenter.isMyFavorite = true
        viewController?.updateButtonFavorite()
    }
}
