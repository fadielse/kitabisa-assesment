//
//  MovieListDAO.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieListDAO: BaseDAO {
    
    var movieList: MovieList?
    
    override init(json: JSON?) {
        super.init(json: json)
        guard let json = json else {
            return
        }
        self.movieList = MovieList(json: json)
    }
}
