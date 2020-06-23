//
//  MyFavoriteViewControllerTests.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import XCTest
@testable import Kitabisa_Movie

// MARK: - Test Setup

class MyFavoriteViewControllerTests: XCTestCase {
    
    // MARK: Data members
    
    var viewController: MyFavoriteViewController?
    var mockViewController: MockMyFavoriteViewController?
    
    // MARK: Overrides
    
    override func setUp() {
        viewController = MyFavoriteViewControllerTests.createViewController()
        mockViewController = MyFavoriteViewControllerTests.createMock(withViewController: viewController)
    }
    
    override func tearDown() {
        viewController = nil
        mockViewController = nil
    }
    
    // MARK: Methods
    
    static func createViewController() -> MyFavoriteViewController? {
        let viewController = MyFavoriteViewController.createModule()
        viewController.loadViewIfNeeded()
        return viewController
    }
    
    static func createMock(withViewController view: MyFavoriteViewController?) -> MockMyFavoriteViewController {
        let mockViewController = MockMyFavoriteViewController(view: view)
        return mockViewController
    }
}

// MARK: - Test IBOutlets

extension MyFavoriteViewControllerTests {
    
    func testHas_tableView() {
        XCTAssertNotNil(viewController?.tableView, "tableView not Found.")
    }
}

// MARK: - Test Methods

extension MyFavoriteViewControllerTests {
    
    // TODO: Implements test case base on requirements
}
