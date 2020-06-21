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
        case topRated = "Top Rated"
        case nowPlaying = "Now Playing"
    }
    
    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonCategory: UIButton!

    private lazy var pickerView: PickerView = {
        let pickerView = PickerView()
        pickerView.didSelectItem = { [weak self] item in
            self?.presenter.getMovieList()
        }
        return pickerView
    }()
    
    var presenter: HomeViewPresenter!
    
    let cellId = "MovieTableViewCell"
    let categories: [MovieCategory] = [.popular, .topRated, .nowPlaying]
    
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
        
    }
    
    func hideLoading() {
        
    }
}

// MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        cell.setupView()
        return cell
    }
}
