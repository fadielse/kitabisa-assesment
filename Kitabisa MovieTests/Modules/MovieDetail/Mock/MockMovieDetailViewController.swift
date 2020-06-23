//
//  MockMovieDetailViewController.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 24/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import XCTest
@testable import Kitabisa_Movie

class MockMovieDetailViewController: MovieDetailViewController {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    init(view: MovieDetailViewController?) {
        super.init(nibName: nil, bundle: nil)
        self.imageMovie = view?.imageMovie
        self.labelTitle = view?.labelTitle
        self.buttonFavorite = view?.buttonFavorite
        self.labelDate = view?.labelDate
        self.labelOverview = view?.labelOverview
    }
}
