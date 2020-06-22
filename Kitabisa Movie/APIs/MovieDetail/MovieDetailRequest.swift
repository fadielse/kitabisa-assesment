//
//  MovieDetailRequest.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation

class MovieDetailRequest {
    
    var movieId: Int = 0
    var apiKey: String?
    var language: String?
    
    func buildForParameters() -> [String: AnyObject] {
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = apiKey as AnyObject?
        parameters["language"] = apiKey as AnyObject?
        return parameters
    }
}
