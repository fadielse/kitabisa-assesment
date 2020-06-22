//
//  MovieDetailPresenter.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import SwiftyJSON

protocol MovieDetailViewPresenter: class {
    init(view: MovieDetailView)
    var movie: MovieListItem? { get set }
    var isMyFavorite: Bool { get set }

    func viewDidLoad()
    func getMovieDetail(withMovieId movieId: Int)
    func addMovieToFavorite()
    func removeMovieFromFavorite()
    func isMovieExistInFavorite() -> Bool
}

protocol MovieDetailView: class {
    func setupView()
    func showLoading()
    func hideLoading()
    func showGetMovieDetailSuccess(withMovieDetail movieDetail: MovieDetail)
    func showGetMovieDetailFailed(withMessage message: String)
    func updateButtonFavorite()
}

class MovieDetailPresenter: MovieDetailViewPresenter {
    
    static func config(withMovieDetailViewController vc: MovieDetailViewController) {
        let presenter = MovieDetailPresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: MovieDetailView
    var movie: MovieListItem? {
        didSet {
            if let movieId = movie?.id {
                getMovieDetail(withMovieId: movieId)
            }
        }
    }
    var isMyFavorite: Bool = false
    var movieDetail: MovieDetail?
    
    required init(view: MovieDetailView) {
        self.view = view
    }
    
    func viewDidLoad() {
        view.setupView()
    }
    
    func getMovieDetail(withMovieId movieId: Int) {
        view.showLoading()
        
        let request = MovieDetailRequest()
        request.apiKey = AppConstant.ApiKey
        request.movieId = movieId
        
        KitabisaMovieAPI.instance.request(ApiMovieDetail.getDetail(request), success: { (json) in
            self.view.hideLoading()
            let movieDetailDao = MovieDetailDAO(json: json)
            if movieDetailDao.success {
                if let movieDetail = movieDetailDao.movieDetail {
                    self.movieDetail = movieDetail
                    self.view.showGetMovieDetailSuccess(withMovieDetail: movieDetail)
                } else {
                    self.view.showGetMovieDetailFailed(withMessage: "Movie list is Empty.")
                }
            } else {
                self.view.showGetMovieDetailFailed(withMessage: movieDetailDao.getMessage())
            }
        }) { (error) in
            self.view.hideLoading()
            self.view.showGetMovieDetailFailed(withMessage: error.getExceptionErrorMessage())
        }
    }
    
    func isMovieExistInFavorite() -> Bool {
        guard let favoriteList = StorageUtils.favoriteList else {
            return false
        }
        return favoriteList.contains(where: { $0.id == movie?.id })
    }
    
    func addMovieToFavorite() {
        var newFavoriteList: [MovieListItem] = []
        if let favoriteList = StorageUtils.favoriteList {
            newFavoriteList = favoriteList
        }
        
        if let movie = movie {
            newFavoriteList.append(movie)
            StorageUtils.favoriteList = newFavoriteList
        }
        
        view.updateButtonFavorite()
    }
    
    func removeMovieFromFavorite() {
        var newFavoriteList: [MovieListItem] = []
        if let favoriteList = StorageUtils.favoriteList {
            newFavoriteList = favoriteList
        }
        
        if let movie = movie, let indexToRemove = newFavoriteList.firstIndex(where: { $0.id == movie.id }) {
            newFavoriteList.remove(at: indexToRemove)
            StorageUtils.favoriteList = newFavoriteList
        }
        
        view.updateButtonFavorite()
    }
}
