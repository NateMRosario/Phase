//
//  FollowersView.swift
//  Phase
//
//  Created by Clint M on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class FollowersView: UIView {
    
    // Custom Delegate
    weak var delegate: FollowersViewDelegate?
    
    // MARK: - Lazy Properties
    lazy var followerOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        return imageView
    }()
    
    lazy var followerTwoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        return imageView
    }()
    
    lazy var followerThreeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        return imageView
    }()
    
    lazy var followerFourImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        return imageView
    }()
    
    lazy var followerFiveImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(followerImageViewTapped))
        return imageView
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
        moreFollowersButton.layer.cornerRadius = moreFollowersButton.bounds.width/2
        followerOneImageView.layer.cornerRadius = followerOneImageView.bounds.width/2.0
        followerTwoImageView.layer.cornerRadius = followerTwoImageView.bounds.width/2.0
        followerThreeImageView.layer.cornerRadius = followerThreeImageView.bounds.width/2.0
        followerFourImageView.layer.cornerRadius = followerFourImageView.bounds.width/2.0
        followerFiveImageView.layer.cornerRadius = followerFiveImageView.bounds.width/2.0
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
    
}

protocol FollowersViewDelegate: class {
    func followerImageViewTapped()
    func moreFollowersButtonTapped()
}
