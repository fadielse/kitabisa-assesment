//
//  CALayer+Style.swift
//  Kitabisa Movie
//
//  Created by Fadilah Hasan on 21/06/20.
//  Copyright © 2020 Fadilah Hasan. All rights reserved.
//

import UIKit

extension CALayer {
    
    func setRadius(withPoints points: CGFloat = 2) {
        self.cornerRadius = points
    }
    
    func setBorders(withColor color: UIColor? = .black, withThickness thickness: CGFloat? = 1) {
        if let color = color {
            self.borderColor = color.cgColor
        }
        if let thickness = thickness {
            self.borderWidth = thickness
        }
    }
    
    func setShadow(
        withColor color: UIColor = .black
        , withOpacity opacity: Float = 0.5
        , withPositionX positionX: CGFloat = 0
        , withPositionY positionY: CGFloat = 2
        , withBlur blur: CGFloat = 4
        , withSpread spread: CGFloat = 0) {
        
        self.shadowColor = color.cgColor
        self.shadowOpacity = opacity
        self.shadowOffset = CGSize(width: positionX, height: positionY)
        self.shadowRadius = blur / 2.0
        if spread == 0 {
            self.shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: spread, dy: spread)
            self.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
}
