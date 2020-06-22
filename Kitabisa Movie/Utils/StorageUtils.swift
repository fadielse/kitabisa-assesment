//
//  StorageUtils.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 23/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation

class StorageUtils {
    
    enum Keys: String {
        case favoriteList = "favoriteList"
    }
    
    static var favoriteList: [MovieListItem]? {
        get {
            guard let
                encodedData = UserDefaults.standard.object(forKey: Keys.favoriteList.rawValue) as? Data
            else {
                return nil
            }
            
            let decoder = JSONDecoder()
            
            if let favoriteMovies = try? decoder.decode([MovieListItem].self, from: encodedData) {
                return favoriteMovies
            } else {
                return nil
            }
        }
        set {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(newValue) {
                UserDefaults.standard.set(encoded, forKey: Keys.favoriteList.rawValue)
            }
        }
    }
}
