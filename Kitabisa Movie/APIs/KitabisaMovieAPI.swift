//
//  KitabisaMovieAPI.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireNetworkActivityLogger
import Reachability
import SwiftyJSON

typealias SuccessResponse = (JSON?) -> Void
typealias ErrorResponse = (ErrorExceptionAPI) -> Void

class KitabisaMovieAPI {
    
    struct Endpoint {
        
        static let baseUrl = "https://api.themoviedb.org/3/movie"
    }
    
    static let instance = KitabisaMovieAPI()
    
    var alamoFireManager: SessionManager = SessionManager.default
    var req: Request?
    
    init() {
        #if DEBUG
        NetworkActivityLogger.shared.level = .debug
        #else
        NetworkActivityLogger.shared.level = .off
        #endif
        self.setAFconfig()
    }
    
    func setAFconfig() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // seconds
        configuration.timeoutIntervalForResource = 30
        self.alamoFireManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    func request(_ request: URLRequestConvertible,
                 success:@escaping SuccessResponse,
                 exception:@escaping ErrorResponse) {
        #if DEBUG
        NetworkActivityLogger.shared.startLogging()
        #endif
        req = alamoFireManager.request(request).responseJSON { response in
            guard case let .failure(error) = response.result else {
                self.handleDataResponse(response: response, success: success, exception: exception)
                self.invalidateAndConfigure()
                return
            }
            self.throwExceptionError(error: error, exception: exception)
            self.invalidateAndConfigure()
        }
    }
    
    func invalidateAndConfigure() {
        #if DEBUG
        NetworkActivityLogger.shared.stopLogging()
        #endif
        self.alamoFireManager.session.finishTasksAndInvalidate()
        self.setAFconfig()
    }
    
    private func handleDataResponse(response: DataResponse<Any>,
                                    success: @escaping SuccessResponse,
                                    exception:@escaping ErrorResponse) {
        
        if let value = response.result.value {
            let jsonValue = JSON(value)
            success(jsonValue)
        } else {
            checkErrorResponse(exception: exception)
        }
    }
    
    private func throwExceptionError(error: Error, exception: @escaping ErrorResponse) {
        if let error = error as? AFError {
            switch error {
            case .invalidURL(let url):
                #if DEBUG
                print("Invalid URL: \(url) - \(error.localizedDescription)")
                #endif
            case .parameterEncodingFailed(let reason):
                #if DEBUG
                print("Parameter encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                #endif
            case .multipartEncodingFailed(let reason):
                #if DEBUG
                print("Multipart encoding failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                #endif
            case .responseValidationFailed(let reason):
                #if DEBUG
                print("Response validation failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                #endif
                
                switch reason {
                case .dataFileNil, .dataFileReadFailed:
                    #if DEBUG
                    print("Downloaded file could not be read")
                    #endif
                case .missingContentType(let acceptableContentTypes):
                    #if DEBUG
                    print("Content Type Missing: \(acceptableContentTypes)")
                    #endif
                case .unacceptableContentType(let acceptableContentTypes, let responseContentType):
                    #if DEBUG
                    print("Response content type: \(responseContentType) was unacceptable: \(acceptableContentTypes)")
                    #endif
                case .unacceptableStatusCode(let code):
                    #if DEBUG
                    print("Response status code was unacceptable: \(code)")
                    #endif
                }
            case .responseSerializationFailed(let reason):
                #if DEBUG
                print("Response serialization failed: \(error.localizedDescription)")
                print("Failure Reason: \(reason)")
                #endif
            }
            #if DEBUG
            print("Underlying error: \(String(describing: error.underlyingError))")
            #endif
        } else if let error = error as? URLError {
            #if DEBUG
            print("URLError occurred: \(error)")
            #endif
            checkErrorResponse(exceptionError: TaskCancelErrorException(error: error), exception: exception)
            return
        } else {
            #if DEBUG
            print("Unknown error: \(String(describing: error))")
            #endif
        }
        
        checkErrorResponse(exception: exception)
    }
    
    private func checkErrorResponse(exceptionError error: ErrorExceptionAPI? = nil, exception:@escaping ErrorResponse) {
        if let reachability = try? Reachability() {
            switch reachability.connection {
            case .none:
                exception(NoInternetConnectionException())
            default:
                if let error = error {
                    exception(error)
                } else {
                    exception(InternalServerErrorException())
                }
            }
        }
    }
}

class NoInternetConnectionException: ErrorExceptionAPI {
    
    init() {
        super.init()
        code = 404
        message = "Mohon periksa kembali koneksi internetmu untuk memuat halaman"
    }
}

class InternalServerErrorException: ErrorExceptionAPI {
    
    init() {
        super.init()
        code = 500
        message = "Maaf, Server kami sedang sibuk saat ini. Kami akan kembali beberapa saat lagi"
    }
}

class TaskCancelErrorException: ErrorExceptionAPI {
    
    init(error: URLError) {
        super.init()
        code = error.errorCode
        message = error.localizedDescription
    }
}
