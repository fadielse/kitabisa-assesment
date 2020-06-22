//
//  BaseDAO.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 22/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

class BaseDAO {
    
    var statusMessage: String?
    var success: Bool = true
    var statusCode: Int?
    
    init(json: JSON? = nil) {
        guard let json = json else {
            return
        }
        self.statusMessage = json["status_message"].string
        if json["success"].exists() {
            self.success = json["success"].boolValue
        }
        self.statusCode = json["status_code"].int
    }
    
    func getMessage() -> String {
        return statusMessage ?? ""
    }
}
