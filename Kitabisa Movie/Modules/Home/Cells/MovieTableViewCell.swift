//
//  MovieTableViewCell.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView() {
        viewContainer.layer.setRadius(withPoints: 8.0)
        viewContainer.layer.setShadow()
    }
}
