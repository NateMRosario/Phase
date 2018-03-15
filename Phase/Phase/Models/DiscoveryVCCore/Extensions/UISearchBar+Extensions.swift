//
//  UISearchBar+Extensions.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

extension UISearchBar {
    var textField: UITextField? {
        return value(forKey: "_searchField") as? UITextField
    }
}
