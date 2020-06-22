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
    
    var indicator : UIView?
    
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
    
    // Show alert view
    func showAlert(withTitle title: String? = nil, andMessage message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    // Spinner Loading
    func showSpinner(onView : UIView) {
        let indicatorView = UIView.init(frame: onView.bounds)
        let uiaiv = UIActivityIndicatorView.init(style: .whiteLarge)
        
        indicatorView.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5)
        uiaiv.startAnimating()
        uiaiv.center = indicatorView.center
        
        DispatchQueue.main.async {
            indicatorView.addSubview(uiaiv)
            onView.addSubview(indicatorView)
        }
        
        indicator = indicatorView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.indicator?.removeFromSuperview()
            self.indicator = nil
        }
    }
}
