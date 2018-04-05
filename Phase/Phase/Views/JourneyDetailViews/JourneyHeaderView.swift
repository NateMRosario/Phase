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
    func showFollowersTapped()
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
    
    lazy var journeyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "This is were the description will appear."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var journeyCaptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.clear
        label.text = "This is were the caption will appear."
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var journeyStartDate: UILabel = {
        let label = UILabel()
        label.text = "45 days ago"
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
        button.setTitleColor(UIColor.blue, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
        button.addTarget(self, action: #selector(showCommentsTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var journeyCommentsUpButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(showCommentsTapped), for: .touchDown)
        return button
    }()
    
    lazy var journeyFollowersButton: UIButton = {
        let button = UIButton()
        button.setTitle("5 followers", for: .normal)
        button.titleLabel?.textAlignment = .right
        button.backgroundColor = UIColor.clear
        button.setTitleColor(UIColor.gray, for: .normal)
        button.setTitleColor(UIColor.blue, for: .highlighted)
        button.setTitleColor(UIColor.black, for: .selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
        button.addTarget(self, action: #selector(showFollowersTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var journeyFollowersUpButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setImage(#imageLiteral(resourceName: "up-arrow"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(showFollowersTapped), for: .touchDown)
        return button
    }()
    
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
        setupJourneyFollowersUpButton()
        setupJourneyFollowersButton()
        setupJourneyCommentsUpButton()
        setupJourneyCaptionLabel()
    }
    
    @objc private func segueToProfileTapped() {
        print("profileTapped")
        delegate?.segueToProfileTapped()
    }
    
    @objc private func showCommentsTapped() {
        print("commentsTapped")
        delegate?.showCommentsTapped()
    }
    
    @objc private func showFollowersTapped() {
        print("showFollowersTapped")
        delegate?.showFollowersTapped()
    }
    
    // MARK: - Constraints
    private func setupThinButton() {
        addSubview(thinButton)
        thinButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(8)
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
    
    private func setupJourneyCaptionLabel() {
        addSubview(journeyCaptionLabel)
        journeyCaptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.top.equalTo(journeyDescriptionLabel
                .snp.bottom).offset(8)
        }
    }
    
    
    private func setupJourneyJourneyStartDate() {
        addSubview(journeyStartDate)
        journeyStartDate.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
            make.bottom.equalTo(self).offset(-12)
        }
    }
    
    private func setupJourneyTotalComments() {
        addSubview(journeyTotalComments)
        journeyTotalComments.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.firstBaseline.equalTo(journeyStartDate.snp.firstBaseline)
        }
    }
    
    private func setupJourneyCommentsUpButton() {
        addSubview(journeyCommentsUpButton)
        journeyCommentsUpButton.snp.makeConstraints { (make) in
            make.leading.equalTo(journeyTotalComments.snp.trailing).offset(12)
            make.centerY.equalTo(journeyTotalComments.snp.centerY)
            make.size.equalTo(10)
        }
    }
    
    private func setupJourneyFollowersUpButton() {
        addSubview(journeyFollowersUpButton)
        journeyFollowersUpButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-12)
            make.centerY.equalTo(journeyStartDate.snp.centerY)
            make.size.equalTo(10)
        }
    }
    
    private func setupJourneyFollowersButton() {
        addSubview(journeyFollowersButton)
        journeyFollowersButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(journeyFollowersUpButton.snp.leading).offset(-8)
            make.firstBaseline.equalTo(journeyStartDate.snp.firstBaseline)
        }
    }

}


