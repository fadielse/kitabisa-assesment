//
//  HomeViewController.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import Foundation
import UIKit

// MARK: - HomeViewController

class HomeViewController: BaseViewController {

    static func createModule() -> HomeViewController {
        let viewController = UIStoryboard.init(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        return viewController
    }
    
    enum MovieCategory: String {
        case popular = "Popular"
        case upcoming = "Upcoming"
        case topRated = "Top Rated"
        case nowPlaying = "Now Playing"
    }
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonCategory: UIButton!

    private lazy var pickerView: PickerView = {
        let pickerView = PickerView()
        pickerView.selectedItem = .popular
        pickerView.didSelectItem = { [weak self] item in
            self?.presenter.getMovieList(withSelectedCategory: item)
        }
        return pickerView
    }()
    
    var presenter: HomeViewPresenter!
    
    let cellId = "MovieTableViewCell"
    let categories: [MovieCategory] = [.popular, .upcoming, .topRated, .nowPlaying]
    
    // MARK: Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        HomePresenter.config(withHomeViewController: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
    private func setupAppNameNavigation() {
        let appLeftItem = UIBarButtonItem()
        appLeftItem.title = "Kitabisa Movie"
        appLeftItem.tintColor = .white
        self.navigationItem.leftBarButtonItem = appLeftItem
    }
    
    private func setupFavoriteBarButton() {
        let favoriteButton = UIBarButtonItem()
        favoriteButton.image = #imageLiteral(resourceName: "ic_favorite").withRenderingMode(.alwaysOriginal)
        favoriteButton.style = .plain
        favoriteButton.target = self
        favoriteButton.action = #selector(self.showFavoriteMovies)
        self.navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func showFavoriteMovies() {
        let myFavoriteVc = MyFavoriteViewController.createModule()
        self.navigationController?.pushViewController(myFavoriteVc, animated: true)
    }
    
    @objc private func showCategories() {
        pickerView.showPicker()
    }
    
    private func showMovieDetail(withMovie movie: MovieListItem) {
        let movieDetailVc = MovieDetailViewController.createModule()
        movieDetailVc.presenter.movie = movie
        self.navigationController?.pushViewController(movieDetailVc, animated: true)
    }
}

// MARK: - HomeView

extension HomeViewController: HomeView {
    func setupView() {
        setupAppNameNavigation()
        setupFavoriteBarButton()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 127.0
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        
        buttonCategory.layer.setRadius()
        buttonCategory.addTarget(self, action: #selector(showCategories), for: .touchUpInside)
        
        pickerView.items = categories
        view.addSubview(pickerView)
    }
    
    func showLoading() {
        showSpinner(onView: view)
    }
    
    func hideLoading() {
        removeSpinner()
    }
    
    func showGetMovieListSuccess(withMovieList movieList: [MovieListItem]) {
        tableView.reloadData()
    }
    
    func showGetMovieListFailed(withMessage message: String) {
        showAlert(andMessage: message)
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
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
