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
    // TODO: Declare view presenter methods
}

protocol MovieDetailView: class {
    // TODO: Declare view methods
}

class MovieDetailPresenter: MovieDetailViewPresenter {
    
    static func config(withMovieDetailViewController vc: MovieDetailViewController) {
        let presenter = MovieDetailPresenter(view: vc)
        vc.presenter = presenter
    }
    
    let view: MovieDetailView
    
    required init(view: MovieDetailView) {
        self.view = view
    }
    
    // TODO: Implement view presenter methods
}
