//
//  HomePresenter.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol HomeViewPresenter: class {
    init(view: HomeView)
    func viewDidLoad()
    func getMovieList()
}

protocol HomeView: class {
    func setupView()
    func showLoading()
    func hideLoading()
}

class HomePresenter: HomeViewPresenter {
    
    static func config(withHomeViewController vc: HomeViewController) {
        let presenter = HomePresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: HomeView
    
    required init(view: HomeView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupView()
        getMovieList()
    }
    
    func getMovieList() {
        
    }
}
