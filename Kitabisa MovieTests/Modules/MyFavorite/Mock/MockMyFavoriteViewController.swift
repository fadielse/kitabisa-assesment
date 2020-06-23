//
//  MockMyFavoriteViewController.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import XCTest
@testable import Kitabisa_Movie

class MockMyFavoriteViewController: MyFavoriteViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(view: MyFavoriteViewController?) {
        super.init(nibName: nil, bundle: nil)
        self.tableView = view?.tableView
    }
}
