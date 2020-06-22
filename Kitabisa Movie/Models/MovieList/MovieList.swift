//
//  MovieList.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

class MovieList {
    
    var page: Int?
    var totalResults: Int?
    var totalPages: Int?
    var results: [Item] = []
    
    init?(json: JSON?) {
        guard let json = json else {
            return nil
        }
        self.page = json["page"].int
        self.totalResults = json["total_results"].int
        self.totalPages = json["total_pages"].int
        
        for result in json["results"].arrayValue {
            if let item = Item(json: result) {
                self.results.append(item)
            }
        }
    }
    
    class Item {
        
        var posterPath: String?
        var id: Int?
        var title: String?
        var overview: String?
        var release_date: String?
        
        init?(json: JSON?) {
            guard let json = json else {
                return nil
            }
            self.posterPath = json["poster_path"].string
            self.id = json["id"].int
            self.title = json["title"].string
            self.overview = json["overview"].string
            self.release_date = json["release_date"].string
        }
        
        func getPosterPageUrl() -> URL? {
            guard let posterPath = self.posterPath else {
                return nil
            }
            return URL(string: "\(AppConstant.imageBasePath)\(posterPath)") ?? nil
        }
    }
}
