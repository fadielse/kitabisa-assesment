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
}

// MARK: - UITableViewDelegate

extension MyFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
}
