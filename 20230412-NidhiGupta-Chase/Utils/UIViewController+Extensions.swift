//
//  UIViewController+Extensions.swift
//  20230412-NidhiGupta-Chase
//
//  Created by Nidhi Gupta on 13/04/23.
//

import UIKit

extension UIViewController {
    
    //Show native alert
    func showAlert(title : String, message : String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
