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
    func getMovieList()
}

protocol MyFavoriteView: class {
    func setupView()
}

class MyFavoritePresenter: MyFavoriteViewPresenter {
    
    static func config(withMyFavoriteViewController vc: MyFavoriteViewController) {
        let presenter = MyFavoritePresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: MyFavoriteView
    
    required init(view: MyFavoriteView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupView()
        getMovieList()
    }
    
    func getMovieList() {
        
    }
}
