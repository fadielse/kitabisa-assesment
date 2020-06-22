//
//  ApiMovieDetail.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import Alamofire

enum ApiMovieDetail: URLRequestConvertible {
    
    case getDetail(_ request: MovieDetailRequest)
    
    var path: String {
        switch self {
        case .getDetail(let request):
            return "/\(request.movieId)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getDetail:
            return .get
        }
    }
    
    var parameter: [String: AnyObject] {
        switch self {
        case .getDetail(let request):
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
