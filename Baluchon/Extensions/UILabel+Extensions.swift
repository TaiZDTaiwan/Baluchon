//
//  Label.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import UIKit

// Background set up for both currency labels.

extension UILabel {
    
    func setRateLabelsBackground() {
        backgroundColor = UIColor.white.withAlphaComponent(0.9)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.9
        layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}
