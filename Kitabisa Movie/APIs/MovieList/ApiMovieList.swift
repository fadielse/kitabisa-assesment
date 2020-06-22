//
//  ApiMovieList.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import Alamofire

enum ApiMovieList: URLRequestConvertible {
    
    case getPopular(_ request: MovieListRequest)
    case getTopRated(_ request: MovieListRequest)
    case getNowPlaying(_ request: MovieListRequest)
    case getUpcoming(_ request: MovieListRequest)
    
    var path: String {
        switch self {
        case .getPopular:
            return "/popular"
        case .getTopRated:
            return "/top_rated"
        case .getNowPlaying:
            return "/now_playing"
        case .getUpcoming:
            return "/upcoming"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getPopular, .getTopRated, .getNowPlaying, .getUpcoming:
            return .get
        }
    }
    
    var parameter: [String: AnyObject] {
        switch self {
        case .getPopular(let request):
            return request.buildForParameters()
        case .getTopRated(let request):
            return request.buildForParameters()
        case .getNowPlaying(let request):
            return request.buildForParameters()
        case .getUpcoming(let request):
            return request.buildForParameters()
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try KitabisaMovieAPI.Endpoint.baseUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(self.path))
        urlRequest.httpMethod = method.rawValue
        return try URLEncoding.default.encode(urlRequest, with: self.parameter)
    }
}
