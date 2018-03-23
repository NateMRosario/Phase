//
//  CarouselCell.swift
//  Phase
//
//  Created by Clint Mejia on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class CarouselCell: UICollectionViewCell {
    
    // MARK: - Outlets
    lazy var activityImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image =  UIImage(named: "g")
        imageView.contentMode = .scaleAspectFill
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
//            make.height.equalTo(self).multipliedBy(0.5)
//            make.width.equalTo(self.snp.width).multipliedBy(0.75)
            make.edges.equalTo(self)
        }
    }
    
}
