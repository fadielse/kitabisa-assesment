//
//  MovieDetailDAO.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieDetailDAO: BaseDAO {
    
    var movieDetail: MovieDetail?
    
    override init(json: JSON?) {
        super.init(json: json)
        guard let json = json else {
            return
        }
        self.movieDetail = MovieDetail(json: json)
    }
}
