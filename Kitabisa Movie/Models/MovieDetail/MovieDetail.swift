//
//  MovieDetail.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieDetail {
    
    var title: String?
    var releaseDate: String?
    var overview: String?
    var posterPath: String?
    
    init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        self.title = json["title"].string
        self.releaseDate = json["releaseDate"].string
        self.overview = json["overview"].string
        self.posterPath = json["posterPath"].string
    }
    
    func getPosterPageUrl() -> URL? {
        guard let posterPath = self.posterPath else {
            return nil
        }
        return URL(string: "\(AppConstant.imageBasePath)\(posterPath)") ?? nil
    }
}
