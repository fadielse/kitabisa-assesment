//
//  MyFavoritePresenter.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MyFavoriteViewPresenter: class {
    init(view: MyFavoriteView)
    func viewDidLoad()
    func getFavoriteMovies()
    func getList() -> [MovieListItem]
    func getListCount() -> Int
}

protocol MyFavoriteView: class {
    func setupView()
    func showGetFavoriteMoviesSuccess()
    func showGetFavoriteMoviesFailed(withMessage message: String)
}

class MyFavoritePresenter: MyFavoriteViewPresenter {
    
    static func config(withMyFavoriteViewController vc: MyFavoriteViewController) {
        let presenter = MyFavoritePresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: MyFavoriteView
    var favoriteMovies: [MovieListItem] = []
    
    required init(view: MyFavoriteView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupView()
        getFavoriteMovies()
    }
    
    func getFavoriteMovies() {
        if let favoriteList = StorageUtils.favoriteList {
            self.favoriteMovies = favoriteList
            view.showGetFavoriteMoviesSuccess()
        } else {
            view.showGetFavoriteMoviesFailed(withMessage: "Failed to get favorite movies.")
        }
    }
    
    func getList() -> [MovieListItem] {
        return favoriteMovies
    }
    
    func getListCount() -> Int {
        return favoriteMovies.count
    }
}
