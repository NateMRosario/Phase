//
//  CarouselView.swift
//  Phase
//
//  Created by Clint Mejia on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class CarouselView: UIView {
    
    // Cell Identifier
    let collectionViewCellID = "CarouselCell"
    
    // MARK: - Lazy variables
    lazy var activityCollectionView: UICollectionView = {
        let layout = CarouselFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing: CGFloat = 8
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = cellSpacing
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor.gray
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: collectionViewCellID)
        return collectionView
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
        backgroundColor = UIColor.lightGray
        setupViews()
    }
    
    // MARK: - Functions
    private func setupViews() {
        setupActivityCollectionView()
    }
    
    private func setupActivityCollectionView() {
        addSubview(activityCollectionView)
        activityCollectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}
