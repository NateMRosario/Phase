//
//  ActivityCollectionViewCell.swift
//  Phase
//
//  Created by Clint Mejia on 3/16/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class ActivityCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    lazy var activityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "g")
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        setupViews()
    }
    
    // required Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupViews()
    }
    
    //MARK: - Functions
    private func commonInit() {
        backgroundColor = UIColor.red
    }
    
    // MARK: - Functions
    func setupViews() {
        setupActivityImageView()
    }
    
//    public func configureCell(with activity: Activity) {
//        activityImageView.image = activity.image
//    }
    
    // Contraints
    private func setupActivityImageView() {
        addSubview(activityImageView)
        activityImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self)
            make.height.equalTo(self)
            make.trailing.equalTo(self)
            make.leading.equalTo(self)
//            make.centerX.equalTo(self)
//            make.edges.equalTo(self)
        }
    }
    
}
