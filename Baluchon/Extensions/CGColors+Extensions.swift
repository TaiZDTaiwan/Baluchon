//
//  Colors.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 16/06/2021.
//

import UIKit

// Different colors used in layouts.

extension CGColor {
    public class var lightBlue: CGColor {
        if #available(iOS 13.0, *) {
            return CGColor(red: 147/255, green: 221/255, blue: 225/255, alpha: 1.0)
        } else {
            return #colorLiteral(red: 0.4764304161, green: 0.8759436011, blue: 0.8881866336, alpha: 1)
        }
    }
    public class var deepBlue: CGColor {
        if #available(iOS 13.0, *) {
            return CGColor(red: 116/255, green: 193/255, blue: 230/255, alpha: 1.0)
        } else {
           return #colorLiteral(red: 0.1904735863, green: 0.3134540021, blue: 1, alpha: 1)
        }
    }
    
    public class var darkBlue: CGColor {
        if #available(iOS 13.0, *) {
            return CGColor(red: 36/255, green: 48/255, blue: 92/255, alpha: 1.0)
        } else {
            return #colorLiteral(red: 0.1867335439, green: 0.2544771135, blue: 0.4366204143, alpha: 1)
        }
    }

}

extension UIColor {
    
    public class var lightBlue: UIColor {
        return UIColor(red: 147/255, green: 221/255, blue: 225/255, alpha: 1.0)
    }
}
