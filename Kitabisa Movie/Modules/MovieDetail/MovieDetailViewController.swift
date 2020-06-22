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
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var buttonFavorite: UIButton!
    @IBOutlet weak var labelOverview: UILabel!
    
    var presenter: MovieDetailViewPresenter!
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MovieDetailPresenter.config(withMovieDetailViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    @IBAction func onButtonFavoriteTapped(_ sender: Any) {
        if presenter.isMovieExistInFavorite() {
            presenter.removeMovieFromFavorite()
        } else {
            presenter.addMovieToFavorite()
        }
    }
}

// MARK: - MovieDetailView

extension MovieDetailViewController: MovieDetailView {
    func setupView() {
        setupBackNavigation()
        
        if presenter.isMovieExistInFavorite() {
            buttonFavorite.setImage(#imageLiteral(resourceName: "ic_favorite_fill"), for: .normal)
        } else {
            buttonFavorite.setImage(#imageLiteral(resourceName: "ic_favorite_empty"), for: .normal)
        }
        
        labelTitle.text = nil
        labelDate.text = nil
        labelOverview.text = nil
    }
    
    func showLoading() {
        showSpinner(onView: view)
    }
    
    func hideLoading() {
        removeSpinner()
    }
    
    func showGetMovieDetailSuccess(withMovieDetail movieDetail: MovieDetail) {
        if let posterImageUrl = movieDetail.getPosterPageUrl() {
            imageMovie.sd_setImage(with: posterImageUrl, completed: nil)
        }
        
        labelTitle.text = movieDetail.title
        labelDate.text = movieDetail.releaseDate
        labelOverview.text = movieDetail.overview
    }
    
    func showGetMovieDetailFailed(withMessage message: String) {
        showAlert(andMessage: message)
    }
    
    func updateButtonFavorite() {
        if presenter.isMovieExistInFavorite() {
            buttonFavorite.setImage(#imageLiteral(resourceName: "ic_favorite_fill"), for: .normal)
        } else {
            buttonFavorite.setImage(#imageLiteral(resourceName: "ic_favorite_empty"), for: .normal)
        }
    }
}
