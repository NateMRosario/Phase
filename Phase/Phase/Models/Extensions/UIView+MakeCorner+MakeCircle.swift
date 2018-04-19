//
//  UIView+MakeCorner+MakeCircle.swift
//  Phase
//
//  Created by Clint M on 4/8/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

extension UIView {
    func makeCorner(withRadius radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.isOpaque = false
    }
    
    func makeCircle() {
        self.layer.masksToBounds = true
        self.clipsToBounds = true
        self.layer.cornerRadius = self.bounds.width/2.0
    }
    
    func drawCircleInView(parentView: UIView, targetView: UIView, color: UIColor, diameter: CGFloat)
    {
        let square = CGSize(width: min(parentView.bounds.width, parentView.bounds.height), height: min(parentView.bounds.width, parentView.bounds.height))
        let center = CGPoint(x: square.width / 2 - diameter, y: square.height / 2 - diameter)
        
        let circlePath = UIBezierPath(arcCenter: center, radius: CGFloat(diameter), startAngle: CGFloat(0), endAngle: CGFloat(Double.pi * 2), clockwise: true)
        let shapeLayer = CAShapeLayer()
        print(targetView.center)
        shapeLayer.path = circlePath.cgPath
        
        shapeLayer.fillColor = color.cgColor
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.lineWidth = 1.0
        
        targetView.backgroundColor = UIColor.clear
        targetView.layer.addSublayer(shapeLayer)
    }
}
