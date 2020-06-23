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
    func getMovieList(withSelectedCategory selectedCategory: HomeViewController.MovieCategory)
    func getList() -> [MovieListItem]
    func getListCount() -> Int
}

protocol HomeView: class {
    func setupView()
    func showLoading()
    func hideLoading()
    func showGetMovieListSuccess()
    func showGetMovieListFailed(withMessage message: String)
}

class HomePresenter: HomeViewPresenter {
    
    static func config(withHomeViewController vc: HomeViewController) {
        let presenter = HomePresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: HomeView
    var movieList: [MovieListItem] = []
    
    required init(view: HomeView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupView()
        getMovieList(withSelectedCategory: .popular)
    }
    
    func getMovieList(withSelectedCategory selectedCategory: HomeViewController.MovieCategory) {
        view.showLoading()
        
        let request = MovieListRequest()
        request.apiKey = AppConstant.ApiKey
        
        var urlRequest: ApiMovieList = ApiMovieList.getPopular(request)
        
        switch selectedCategory {
        case .popular:
            urlRequest = ApiMovieList.getPopular(request)
        case .upcoming:
            urlRequest = ApiMovieList.getUpcoming(request)
        case .topRated:
            urlRequest = ApiMovieList.getTopRated(request)
        case .nowPlaying:
            urlRequest = ApiMovieList.getNowPlaying(request)
        }
        
        KitabisaMovieAPI.instance.request(urlRequest, success: { (json) in
            self.view.hideLoading()
            let movieListDao = MovieListDAO(json: json)
            if movieListDao.success {
                if let movieList = movieListDao.movieList?.results {
                    self.movieList = movieList
                    self.view.showGetMovieListSuccess()
                } else {
                    self.view.showGetMovieListFailed(withMessage: "Movie list is Empty.")
                }
            } else {
                self.view.showGetMovieListFailed(withMessage: movieListDao.getMessage())
            }
        }) { (error) in
            self.view.hideLoading()
            self.view.showGetMovieListFailed(withMessage: error.getExceptionErrorMessage())
        }
    }
    
    func getList() -> [MovieListItem] {
        return movieList
    }
    
    func getListCount() -> Int {
        return movieList.count
    }
}
