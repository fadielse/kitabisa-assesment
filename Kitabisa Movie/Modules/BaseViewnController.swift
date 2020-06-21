//
//  BaseViewnController.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private static let iconBack = UIImage(named: "ic_back")?.withRenderingMode(.alwaysTemplate)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // Setup Custom back Navigation Bar
    func setupBackNavigation() {
        let backButton = UIBarButtonItem()
        backButton.image = BaseViewController.iconBack
        backButton.style = .plain
        backButton.target = self
        backButton.action = #selector(self.customBackPressed(_:))
        self.navigationItem.leftBarButtonItem = backButton
        self.navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func isModal() -> Bool {
        if self.navigationController?.viewControllers.count == 1 {
            return true
        }
        return false
    }
    
    @objc func customBackPressed(_ sender: UIBarButtonItem) {
        if isModal() {
            self.dismiss(animated: true, completion: nil)
        } else {
            _ = self.navigationController?.popViewController(animated: true)
        }
    }
}
