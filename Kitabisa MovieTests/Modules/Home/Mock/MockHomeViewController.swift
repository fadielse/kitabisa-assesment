//
//  MockHomeViewController.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import XCTest
@testable import Kitabisa_Movie

class MockHomeViewController: HomeViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(view: HomeViewController?) {
        super.init(nibName: nil, bundle: nil)
        self.tableView = view?.tableView
        self.buttonCategory = view?.buttonCategory
    }
}
