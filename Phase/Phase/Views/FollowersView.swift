//
//  FollowersView.swift
//  Phase
//
//  Created by Clint M on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class FollowersView: UIView {
    
    // MARK: - Lazy Properties
    lazy var followerOneImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
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
        setupFollowerOneImageView()
        //        setupFollowerTwoImageView()
        //        setupFollowerThreeImageView()
        //        setupFollowerFourImageView()
        //        setupFollowerFiveImageView()
        setupMoreFollowersButton()
    }
    
    // profileImageView corner radius implementation
    override func layoutSubviews() {
        super.layoutSubviews()
        moreFollowersButton.layer.cornerRadius = moreFollowersButton.bounds.width/2
        followerOneImageView.layer.cornerRadius = followerOneImageView.bounds.width/2.0
        //        followerTwoImageView.layer.cornerRadius = followerTwoImageView.bounds.width/2.0
        //        followerThreeImageView.layer.cornerRadius = followerThreeImageView.bounds.width/2.0
        //        followerFourImageView.layer.cornerRadius = followerFourImageView.bounds.width/2.0
        //        followerFiveImageView.layer.cornerRadius = followerFiveImageView.bounds.width/2.0
    }
    
    public func getResizePercentage(usersFollowers: Int, userWithHighestFollowers: Int) -> Double {
        let percentage = Double(usersFollowers) / Double(userWithHighestFollowers)
        return percentage
    }
    
    private func setupFollowerOneImageView() {
        addSubview(followerOneImageView)
        followerOneImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(self).offset(10)
            make.height.equalTo(snp.height).multipliedBy(getResizePercentage(usersFollowers: 25, userWithHighestFollowers: 100))
            make.width.equalTo(followerOneImageView.snp.height)
        }
    }
    
    private func setupMoreFollowersButton() {
        addSubview(moreFollowersButton)
        moreFollowersButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-8)
            make.bottom.equalTo(self).offset(-8)
            make.height.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(followerOneImageView.snp.height)
        }
    }
    
    
}
