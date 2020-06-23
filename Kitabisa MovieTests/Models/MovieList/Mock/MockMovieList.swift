//
//  MockMovieList.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import XCTest
import SwiftyJSON
@testable import Kitabisa_Movie

class MockMovieList: MovieList {
    
    var expectationForValidGetItems: (XCTestExpectation, Int)?
    
    override init?(json: JSON?) {
        super.init(json: json)
    }
}
