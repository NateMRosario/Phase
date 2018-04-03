//
//  RoundUIViewCorner.swift
//  Phase
//
//  Created by Clint M on 4/3/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

extension UIView {
    func round(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
