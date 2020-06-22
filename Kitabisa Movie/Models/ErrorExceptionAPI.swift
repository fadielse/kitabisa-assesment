//
//  ErrorExceptionAPI.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol ErrorException {
    func getExceptionErrorMessage() -> String
    func getExceptionErrorCode() -> Int
}

class ErrorExceptionAPI {
    
    static internal let kSuccessKey = "success"
    static internal let kCodeKey = "status_code"
    static internal let kMessageKey = "status_message"
    
    var success: Bool = false
    var code: Int = 500
    var message: String?
    
    init(json: JSON? = nil) {
        if let json = json {
            success = json[ErrorExceptionAPI.kSuccessKey].boolValue
            code = json[ErrorExceptionAPI.kCodeKey].intValue
            message = json[ErrorExceptionAPI.kMessageKey].string
        }
    }
}

extension ErrorExceptionAPI: ErrorException {
    
    func getExceptionErrorMessage() -> String {
        guard let message = message else {
            return ""
        }
        return message
    }

    func getExceptionErrorCode() -> Int {
        return code
    }
}
