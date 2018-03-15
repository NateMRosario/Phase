//
//  CALayer+Extensions.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

extension CALayer {
    func setAnchorPoint(newAnchorPoint: CGPoint, forView view: UIView) {
        var newPoint = CGPoint(x: bounds.size.width * newAnchorPoint.x, y: bounds.size.height * newAnchorPoint.y)
        var oldPoint = CGPoint(x: bounds.size.width * anchorPoint.x, y: bounds.size.height * anchorPoint.y)
        
        newPoint = newPoint.applying(view.transform)
        oldPoint = oldPoint.applying(view.transform)
        
        var position = self.position
        position.x -= oldPoint.x
        position.x += newPoint.x
        
        position.y -= oldPoint.y
        position.y += newPoint.y
        
        position.x = newPoint.x
        position.y = newPoint.y
        
        anchorPoint = newAnchorPoint
        self.position = position
    }
}

