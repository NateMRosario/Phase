//
//  JourneyCarouselView.swift
//  Phase
//
//  Created by Clint Mejia on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

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

class JourneyCarouselView: UIView {
    
    // Cell Identifier
    let collectionViewCellID = "CarouselCell"
    
    // MARK: - Lazy variables
    lazy var carouselCollectionView: iCarousel = {
        let carousel = iCarousel()
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing: CGFloat = 8
        let numberOfCells: CGFloat = 3
        carousel.type = .coverFlow
        carousel.clipsToBounds = true
        return carousel
    }()
    
    lazy var carouselSlider: UISlider = {
        let slider = UISlider()
        slider.tintColor = UIColor.black
        return slider
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = UIColor(hue: 120/360, saturation: 0/100, brightness: 92/100, alpha: 1.0)
        setupViews()
    }
    
    // MARK: - Functions
    private func setupViews() {
        setupCarouselCollectionView()
        setupCarouselSlider()
    }
    
    private func setupCarouselCollectionView() {
        addSubview(carouselCollectionView)
        carouselCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.6)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
        }
    }
    
    private func setupCarouselSlider() {
        addSubview(carouselSlider)
        carouselSlider.snp.makeConstraints { (make) in
            make.top.equalTo(carouselCollectionView.snp.bottom).offset(16)
            make.width.equalTo(self).multipliedBy(0.75)
            make.height.equalTo(5)
            make.centerX.equalTo(self)
        }
    }
    
}
