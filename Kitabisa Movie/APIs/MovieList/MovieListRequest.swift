//
//  MovieListRequest.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation

class MovieListRequest {
    
    var apiKey: String?
    var language: String?
    var page: Int?
    
    func buildForParameters() -> [String: AnyObject] {
        var parameters: [String: AnyObject] = [:]
        parameters["api_key"] = apiKey as AnyObject?
        parameters["language"] = language as AnyObject?
        parameters["page"] = page as AnyObject?
        return parameters
    }
}
