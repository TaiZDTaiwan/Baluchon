//
//  Float.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import UIKit

// The distance bewteen the top of the screen and the safe area begininng.

extension CGFloat {
    public static var topPadding: CGFloat {
    let window = UIApplication.shared.windows[0]
    return window.safeAreaInsets.top
    }
}
