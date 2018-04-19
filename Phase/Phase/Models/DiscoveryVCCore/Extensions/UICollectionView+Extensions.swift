//
//  UICollectionView+Extensions.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import Foundation

import UIKit
extension UICollectionView {
    func register<T: UICollectionViewCell>(cellTypes: T.Type...) {
        cellTypes.forEach { cellType in
            let className = String(describing: cellType.self)
            let nib = UINib(nibName: className, bundle: nil)
            register(nib, forCellWithReuseIdentifier: className)
        }
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(with type: T.Type, for indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: String(describing: type.self), for: indexPath) as! T
    }
}
