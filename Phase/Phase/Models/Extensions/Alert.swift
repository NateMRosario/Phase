//
//  Alert.swift
//  Phase
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
