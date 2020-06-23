//
//  HomeViewControllerTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
@testable import Kitabisa_Movie

// MARK: - Test Setup

class HomeViewControllerTests: XCTestCase {
    
    // MARK: Data members
    
    var viewController: HomeViewController?
    var mockViewController: MockHomeViewController?
    
    // MARK: Overrides
    
    override func setUp() {
        viewController = HomeViewControllerTests.createViewController()
        mockViewController = HomeViewControllerTests.createMock(withViewController: viewController)
    }
    
    override func tearDown() {
        viewController = nil
        mockViewController = nil
    }
    
    // MARK: Methods
    
    static func createViewController() -> HomeViewController? {
        let viewController = HomeViewController.createModule()
        viewController.loadViewIfNeeded()
        return viewController
    }
    
    static func createMock(withViewController view: HomeViewController?) -> MockHomeViewController {
        let mockViewController = MockHomeViewController(view: view)
        return mockViewController
    }
}

// MARK: - Test IBOutlets

extension HomeViewControllerTests {
    
    func testHas_tableView() {
        XCTAssertNotNil(viewController?.tableView, "tableView not found.")
    }
    
    func testHas_buttonCategory() {
        XCTAssertNotNil(viewController?.buttonCategory, "buttonCategory is missing.")
    }
}

// MARK: - Test Methods

extension HomeViewControllerTests {
    
    // TODO: Implements test case base on requirements
}
