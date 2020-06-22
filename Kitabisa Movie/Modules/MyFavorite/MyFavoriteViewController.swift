//
//  MyFavoriteViewController.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - MyFavoriteViewController

class MyFavoriteViewController: BaseViewController {

    static func createModule() -> MyFavoriteViewController {
        let viewController = UIStoryboard.init(name: "MyFavorite", bundle: nil).instantiateViewController(withIdentifier: "MyFavoriteViewController") as! MyFavoriteViewController
        return viewController
    }
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: MyFavoriteViewPresenter!
    
    let cellId = "MovieTableViewCell"
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        MyFavoritePresenter.config(withMyFavoriteViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.getFavoriteMovies()
    }
    
    private func showMovieDetail(withMovie movie: MovieListItem) {
        let movieDetailVc = MovieDetailViewController.createModule()
        movieDetailVc.presenter.movie = movie
        self.navigationController?.pushViewController(movieDetailVc, animated: true)
    }
}

// MARK: - MyFavoriteView

extension MyFavoriteViewController: MyFavoriteView {
    func setupView() {
        setupBackNavigation()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 127.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
    }
    
    func showGetFavoriteMoviesSuccess() {
        tableView.reloadData()
    }
    
    func showGetFavoriteMoviesFailed(withMessage message: String) {
        showAlert(andMessage: message)
    }
}

// MARK: - UITableViewDelegate

extension MyFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.getListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let movieList = presenter.getList()
        
        if movieList.indices.contains(indexPath.row) {
            cell.setupView(withMovie: movieList[indexPath.row])
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movieList = presenter.getList()
        
        if movieList.indices.contains(indexPath.row) {
            showMovieDetail(withMovie: movieList[indexPath.row])
        }
    }
}
