//
//  View.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import UIKit

extension UIView {
    
    // Main view color background for exchange rate and translater pages.
    
    func setTemplateBackground() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [CGColor.darkBlue, CGColor.lightBlue]
        gradientLayer.locations = [0, 0.5]
        gradientLayer.frame = bounds
                
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    // The various background layouts for each weather conditions.
    
    private func weatherBackgroundLayout(color: UIColor?, imageName: String, topDistance: CGFloat) {
        backgroundColor = color
        let image = UIImage(named: imageName)
        let imageView = UIImageView(image: image!)
        imageView.frame = CGRect(x: 10, y: topDistance, width: 92, height: 92)
        self.addSubview(imageView)
    }
    
    func clear(_ topDistance: CGFloat) {
        weatherBackgroundLayout(color: #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1).withAlphaComponent(0.5), imageName: "Clear Icon", topDistance: topDistance)
    }
    
    func clouds(_ topDistance: CGFloat) {
        weatherBackgroundLayout(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(0.3), imageName: "Clouds Icon", topDistance: topDistance)
    }
    
    func dust(_ topDistance: CGFloat) {
        weatherBackgroundLayout(color: #colorLiteral(red: 0.3098039329, green: 0.2039215714, blue: 0.03921568766, alpha: 1).withAlphaComponent(0.3), imageName: "Dust Icon", topDistance: topDistance)
    }
    
    func haze(_ topDistance: CGFloat) {
        weatherBackgroundLayout(color: #colorLiteral(red: 0.8326150775, green: 0.9678236842, blue: 1, alpha: 1).withAlphaComponent(0.3), imageName: "Haze Icon", topDistance: topDistance)
    }
    
    func mist(_ topDistance: CGFloat) {
        weatherBackgroundLayout(color: #colorLiteral(red: 0.8326150775, green: 0.9678236842, blue: 1, alpha: 1).withAlphaComponent(0.3), imageName: "Haze Icon", topDistance: topDistance)
    }
    
    func rain(_ topDistance: CGFloat) {
        weatherBackgroundLayout(color: #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).withAlphaComponent(1.0), imageName: "Rain Icon", topDistance: topDistance)
    }
    
    func thunderstorm(_ topDistance: CGFloat) {
        weatherBackgroundLayout(color: #colorLiteral(red: 0.173522681, green: 0.1938724518, blue: 0.3012402058, alpha: 1).withAlphaComponent(0.8), imageName: "Thunderstorm Icon", topDistance: topDistance)
    }
}
