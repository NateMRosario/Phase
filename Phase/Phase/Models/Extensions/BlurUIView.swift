//
//  BlurUIView.swift
//  Phase
//
//  Created by Clint M on 4/3/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

extension UIView {
    func blur() {
        let blurEffect = UIBlurEffect(style: .light)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
    
    func unBlur() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
}
