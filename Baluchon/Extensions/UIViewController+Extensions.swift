//
//  UIViewController+Extensions.swift
//  Baluchon
//
//  Created by Raphaël Huang-Dubois on 23/06/2021.
//

import UIKit

// Generic function to display an alert if error.

extension UIViewController {
    func presentAlert(_ message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertVC, animated: true, completion: nil)
    }
}
