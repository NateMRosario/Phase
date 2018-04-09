//
//  FollowersView.swift
//  Phase
//
//  Created by Clint M on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class JourneyFollowersImagesView: UIView {
    
    // Custom Delegate
    weak var delegate: FollowersViewDelegate?
    
    // MARK: - Lazy Properties
    lazy var followerOneImageView: RoundedfollowersView = {
        let roundedView = RoundedfollowersView.init(tag: 0)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        roundedView.addGestureRecognizer(tapRecognizer)
        roundedView.imageView.image = #imageLiteral(resourceName: "man1.jpg")
        return roundedView
    }()
    
    lazy var followerTwoImageView: RoundedfollowersView = {
        let roundedView = RoundedfollowersView.init(tag: 1)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        roundedView.addGestureRecognizer(tapRecognizer)
        roundedView.imageView.image = #imageLiteral(resourceName: "man6.jpg")
        return roundedView
    }()
    
    lazy var followerThreeImageView: RoundedfollowersView = {
        let roundedView = RoundedfollowersView.init(tag: 2)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        roundedView.addGestureRecognizer(tapRecognizer)
        roundedView.imageView.image = #imageLiteral(resourceName: "woman4.jpg")
        return roundedView
    }()
    
    lazy var followerFourImageView: RoundedfollowersView = {
        let roundedView = RoundedfollowersView.init(tag: 3)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        roundedView.addGestureRecognizer(tapRecognizer)
        roundedView.imageView.image = #imageLiteral(resourceName: "man2.jpg")
        return roundedView
    }()
    
    lazy var followerFiveImageView: RoundedfollowersView = {
        let roundedView = RoundedfollowersView.init(tag: 4)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        roundedView.addGestureRecognizer(tapRecognizer)
        roundedView.imageView.image = #imageLiteral(resourceName: "woman5.jpg")
        return roundedView
    }()
    
    lazy var moreFollowersButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.backgroundColor = UIColor.white
        button.layer.borderColor = UIColor.gray.cgColor
        button.setTitle("53 More", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 8)
        button.titleLabel?.minimumScaleFactor = 2
        button.contentEdgeInsets = UIEdgeInsetsMake(8, 8, 8, 8)
        button.clipsToBounds = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(moreFollowersButtonTapped))
        return button
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
        setupMoreFollowersButton()
        setupFollowerOneImageView()
        setupFollowerTwoImageView()
        setupFollowerThreeImageView()
        setupFollowerFourImageView()
        setupFollowerFiveImageView()
    }
    
    // profileImageView corner radius implementation
    override func layoutSubviews() {
        super.layoutSubviews()
        moreFollowersButton.makeCircle()
        followerOneImageView.makeCircle()
        followerTwoImageView.makeCircle()
        followerThreeImageView.makeCircle()
        followerFourImageView.makeCircle()
        followerFiveImageView.makeCircle()
    }
    
    public func getResizePercentage(usersFollowers: Int, userWithHighestFollowers: Int) -> Double {
        let percentage = Double(usersFollowers) / Double(userWithHighestFollowers)
        return percentage
    }
    
    @objc public func followerImageViewTapped(sender: UIImageView, target:UIViewController) {
        print("followerImageViewTapped")
        delegate?.followerImageViewTapped()
    }
    
    @objc public func moreFollowersButtonTapped(sender: UIImageView, target:UIViewController) {
        print("moreFollowersButtonTapped")
        delegate?.moreFollowersButtonTapped()
    }
    
    // MARK: - Constraints
    private func setupFollowerOneImageView() {
        addSubview(followerOneImageView)
        followerOneImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(snp.height).multipliedBy(getResizePercentage(usersFollowers: 25, userWithHighestFollowers: 100))
            make.width.equalTo(followerOneImageView.snp.height)
        }
    }
    
    private func setupFollowerTwoImageView() {
        addSubview(followerTwoImageView)
        followerTwoImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(followerOneImageView.snp.trailing).offset(8)
            make.top.equalTo(followerOneImageView.snp.bottom).offset(10)
            make.height.equalTo(snp.height).multipliedBy(getResizePercentage(usersFollowers: 10, userWithHighestFollowers: 100))
            make.width.equalTo(followerTwoImageView.snp.height)
        }
    }
    
    private func setupFollowerThreeImageView() {
        addSubview(followerThreeImageView)
        followerThreeImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-25)
            make.top.equalTo(self).offset(50)
            make.height.equalTo(snp.height).multipliedBy(getResizePercentage(usersFollowers: 12, userWithHighestFollowers: 100))
            make.width.equalTo(followerThreeImageView.snp.height)
        }
    }
    
    private func setupFollowerFourImageView() {
        addSubview(followerFourImageView)
        followerFourImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(moreFollowersButton.snp.leading).offset(-28)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(snp.height).multipliedBy(getResizePercentage(usersFollowers: 40, userWithHighestFollowers: 100))
            make.width.equalTo(followerFourImageView.snp.height)
        }
    }
    
    private func setupFollowerFiveImageView() {
        addSubview(followerFiveImageView)
        followerFiveImageView.snp.makeConstraints { (make) in
            make.trailing.equalTo(followerThreeImageView.snp.leading).offset(-8)
            make.top.equalTo(followerTwoImageView.snp.bottom).offset(10)
            make.height.equalTo(snp.height).multipliedBy(getResizePercentage(usersFollowers: 25, userWithHighestFollowers: 100))
            make.width.equalTo(followerFiveImageView.snp.height)
        }
    }
    
    private func setupMoreFollowersButton() {
        addSubview(moreFollowersButton)
        moreFollowersButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-8)
            make.bottom.equalTo(self).offset(-8)
            make.height.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(moreFollowersButton.snp.height)
        }
    }
    
//    public func configureFollowersView() {
//        followerOneImageView.image =
//        followerTwoImageView.image =
//        followerThreeImageView.image =
//        followerFourImageView.image =
//        followerFiveImageView.image =
//        moreFollowersButton.titleLabel?.text = ""
//    }
}

protocol FollowersViewDelegate: class {
    func followerImageViewTapped()
    func moreFollowersButtonTapped()
}
