//
//  MovieTableViewCell.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import UIKit
import SDWebImage

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    @IBOutlet weak var labelOverview: UILabel!
    
    var movie: MovieList.Item?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setupView(withMovie movie: MovieList.Item) {
        viewContainer.layer.setRadius(withPoints: 8.0)
        viewContainer.layer.setShadow()
        
        if let posterImageUrl = movie.getPosterPageUrl() {
            imageMovie.sd_setImage(with: posterImageUrl, completed: nil)
        }
        
        labelTitle.text = movie.title
        labelReleaseDate.text = movie.release_date
        labelOverview.text = movie.overview
    }
}
