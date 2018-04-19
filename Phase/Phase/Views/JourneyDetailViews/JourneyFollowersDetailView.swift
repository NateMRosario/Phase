//
//  JourneyFollowersView.swift
//  Phase
//
//  Created by Clint Mejia on 4/3/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

// MARK: - Custom Delegate
protocol JourneyFollowersDetailViewDelegate: class {
    
}

class JourneyFollowersDetailView: UIView {

    // Custom Delegate
    weak var delegate: JourneyFollowersDetailViewDelegate?
    
    // MARK: - Properties
    public let journeyFollowersImagesView = JourneyFollowersImagesView()

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Functions
    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
    }
    
    private func setupViews() {
        setJourneyFollowersImagesViewConstraints()
    }
    
    // MARK: - Constraints
    private func setJourneyFollowersImagesViewConstraints() {
        addSubview(journeyFollowersImagesView)
        journeyFollowersImagesView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(12)
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.bottom.equalTo(self).offset(-12)
        }
    }
    
}
