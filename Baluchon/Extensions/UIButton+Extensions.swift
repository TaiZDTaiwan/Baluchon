//
//  Button.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import UIKit

extension UIButton {
    
    // Set the background color for the calculator buttons in the exchange rate view.
    func setBackgroundColor() {
        backgroundColor = UIColor.black.withAlphaComponent(0.1)
    }
    
    // To align one button's image and title vertically and centered.
    private func alignImageAndTitleVertically(padding: CGFloat = 1.5) {
        let imageSize = self.imageView!.frame.size
        let titleSize = self.titleLabel!.frame.size
        let totalHeight = imageSize.height + titleSize.height + padding

        self.imageEdgeInsets = UIEdgeInsets(
            top: -(totalHeight - imageSize.height),
            left: (self.frame.size.width - imageSize.width) / 2,
            bottom: 0,
            right: 0
        )

        self.titleEdgeInsets = UIEdgeInsets(
            top: 0,
            left: -imageSize.width,
            bottom: -(totalHeight - titleSize.height),
            right: 0
        )
    }
    
    // To set the euro button's background and layout in the exchange rate view.
    func setEuroButtonBackgroundAndLayout() {
        let imageEuro = UIImage(named: "Euro Icon")?.withRenderingMode(.alwaysTemplate)
        self.setImage(imageEuro, for: .normal)
        self.tintColor = UIColor.lightBlue
        alignImageAndTitleVertically()
    }
    
    // To set the other currency button's background and layout in the exchange rate view.
    func setOtherCurrencyButtonBackgroundAndLayout() {
        let imageSelectedCurrency = UIImage(named: "Money Icon")?.withRenderingMode(.alwaysTemplate)
        self.setImage(imageSelectedCurrency, for: .normal)
        self.tintColor = UIColor.lightBlue
        alignImageAndTitleVertically()
    }
}
