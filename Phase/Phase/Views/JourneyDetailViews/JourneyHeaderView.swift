//
//  JourneyHeaderView.swift
//  Phase
//
//  Created by Clint Mejia on 3/27/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol JourneyHeaderDelegate: class {
    func showCommentsTapped()
    func segueToProfileTapped()
}


class JourneyHeaderView: UIView {
    
    // MARK: - Delegate
    weak var delegate: JourneyHeaderDelegate?
    
    // MARK: - Lazy variables
    lazy var thinButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.gray.cgColor
        button.layer.borderWidth = 0.5
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 1
        button.layer.shadowOffset = CGSize(width: -1, height: 1)
        button.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        button.layer.shouldRasterize = true
        button.layer.rasterizationScale = UIScreen.main.scale
        button.layer.masksToBounds = false
        button.layer.shadowRadius = 1
        button.layer.cornerRadius = 4
        button.backgroundColor = UIColor(hue: 0/360, saturation: 0/100, brightness: 98/100, alpha: 1.0)
        button.addTarget(self, action: #selector(showCommentsTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var journeyUserNamelabel: UIButton = {
        let button = UIButton()
        button.setTitle("Ty PodMaster", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        button.addTarget(self, action: #selector(segueToProfileTapped), for: .touchUpInside)
        return button
    }()
    
//    lazy var journeyUserNamelabel: UILabel = {
//        let label = UILabel()
//        label.text = "Ty PodMaster"
//        label.textAlignment = .left
//        label.backgroundColor = UIColor.clear
//        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        return label
//    }()
    
    lazy var journeyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "\"Ty PodMaster. Ty PodMaster. Ty PodMaster.\""
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var journeyStartDate: UILabel = {
        let label = UILabel()
        label.text = "Started: 45 days ago"
        label.textAlignment = .left
        label.backgroundColor = UIColor.clear
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        return label
    }()
    
    lazy var journeyTotalComments: UIButton = {
        let button = UIButton()
        button.setTitle("5 comments", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
        button.addTarget(self, action: #selector(showCommentsTapped), for: .touchUpInside)
        return button
    }()
    
//    lazy var journeyTotalComments: UILabel = {
//        let label = UILabel()
//        label.text = "5 comments"
//        label.textAlignment = .right
//        label.backgroundColor = UIColor.clear
//        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
//        return label
//    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
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
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        journeyProfileImageView.layer.cornerRadius = journeyProfileImageView.bounds.width/2.0
//    }
    
    private func setupViews() {
        setupThinButton()
        setupJourneyUserNamelabel()
        setupJourneyDescriptionLabel()
        setupJourneyJourneyStartDate()
        setupJourneyTotalComments()
    }
    
    @objc private func segueToProfileTapped() {
        print("profile")
        delegate?.segueToProfileTapped()
    }
    
    @objc private func showCommentsTapped() {
        print("as")
        delegate?.showCommentsTapped()
    }
    
    // MARK: - Constraints
    private func setupThinButton() {
        addSubview(thinButton)
        thinButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(5)
            make.width.equalTo(self).multipliedBy(0.19)
        }
    }
    
    private func setupJourneyUserNamelabel() {
        addSubview(journeyUserNamelabel)
        journeyUserNamelabel.snp.makeConstraints { (make) in
            make.top.equalTo(thinButton.snp.bottom).offset(6)
            make.leading.equalTo(self).offset(12)
        }
    }
    
    private func setupJourneyDescriptionLabel() {
        addSubview(journeyDescriptionLabel)
        journeyDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.top.equalTo(journeyUserNamelabel.snp.bottom).offset(4)
        }
    }
    
    private func setupJourneyJourneyStartDate() {
        addSubview(journeyStartDate)
        journeyStartDate.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.top.equalTo(journeyDescriptionLabel.snp.bottom).offset(16)
        }
    }
    
    private func setupJourneyTotalComments() {
        addSubview(journeyTotalComments)
        journeyTotalComments.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-12)
            make.firstBaseline.equalTo(journeyStartDate.snp.firstBaseline)
        }
    }
}

