//
//  JourneyCarouselView.swift
//  Phase
//
//  Created by Clint Mejia on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

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
    
    //    lazy var activityCollectionView: UICollectionView = {
    //        let layout = CollectionViewFlowLayout()
    //        layout.scrollDirection = .horizontal
    //        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
    //        let screenHeight: CGFloat = UIScreen.main.bounds.height
    //        let screenWidth: CGFloat = UIScreen.main.bounds.width
    //        let cellSpacing: CGFloat = 8
    //        let numberOfCells: CGFloat = 3
    //        let numberOfSpaces: CGFloat = numberOfCells
    //        layout.itemSize = CGSize(width: (screenWidth - (cellSpacing * numberOfSpaces)) / (numberOfCells + 0.5), height: screenHeight * 0.11)
    //        layout.minimumLineSpacing = cellSpacing
    //        layout.minimumInteritemSpacing = cellSpacing
    //        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    //        collectionView.backgroundColor = UIColor.gray
    //        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: collectionViewCellID)
    //        return collectionView
    //    }()
    
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
        backgroundColor = UIColor.white
        setupViews()
    }
    
    // MARK: - Functions
    private func setupViews() {
        setupCarouselSlider()
        setupCarouselCollectionView()
    }
    
    private func setupCarouselCollectionView() {
        addSubview(carouselCollectionView)
        carouselCollectionView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(carouselSlider.snp.top)
        }
    }
    
    private func setupCarouselSlider() {
        addSubview(carouselSlider)
        carouselSlider.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-8)
            make.width.equalTo(self).multipliedBy(0.9)
            make.centerX.equalTo(self)
        }
    }
    
}
