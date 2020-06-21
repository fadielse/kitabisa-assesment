//
//  MovieDetailViewController.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MovieDetailViewController

class MovieDetailViewController: BaseViewController {

    static func createModule() -> MovieDetailViewController {
        let viewController = UIStoryboard.init(name: "MovieDetail", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        return viewController
    }
    
    // MARK: Properties
    
    var presenter: MovieDetailViewPresenter!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MovieDetailPresenter.config(withMovieDetailViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - MovieDetailView

extension MovieDetailViewController: MovieDetailView {
    // TODO: implement view methods
}
