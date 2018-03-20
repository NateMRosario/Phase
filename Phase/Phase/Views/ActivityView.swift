//
//  ActivityView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

extension UIView {
    enum ViewSide {
        case left, right, top, bottom
    }
    
    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {
        
        let border = CALayer()
        border.backgroundColor = color
        
        switch side {
        case .left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height)
        case .right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height)
        case .top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness)
        case .bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness)
        }
        layer.addSublayer(border)
    }
}

class ActivityView: UIView {
    
    // Cell Identifier
    let collectionViewCellID = "ActivityCollectionViewCell"
    
    // MARK: - Lazy variables
    lazy var activityCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        let screenHeight: CGFloat = UIScreen.main.bounds.height
        let screenWidth: CGFloat = UIScreen.main.bounds.width
        let cellSpacing: CGFloat = 0
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = cellSpacing
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight)
        layout.minimumLineSpacing = cellSpacing
        layout.minimumInteritemSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView.backgroundColor = UIColor.gray
        collectionView.register(ActivityCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellID)
        return collectionView
    }()
    
    lazy var activityHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Activity"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    lazy var timePostedLabel: UILabel = {
        let label = UILabel()
        label.text = "32 mins ago"
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 10, weight: .regular)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    lazy var activityHashTagLabel: UILabel = {
        let label = UILabel()
        label.text = "#100DaysOfCode"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    lazy var activityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is my 51st day of the challenge!"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        return label
    }()
    
    lazy var subscribeButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.backgroundColor = UIColor.blue
        button.setTitle("Subscribe", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8)
        return button
    }()
    
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
    
    // MARK: - Constants
    let followersView = FollowersView()
    
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
        setCollectionViewAttributes()
    }
    
    // MARK: - Functions
    private func setupViews() {
        setupActivityHeaderLabel()
        setupProfileImageView()
        setupUsernameLabel()
        setupTimepostedLabel()
        setupActivityCollectionView()
        setupSubscribeButton()
        setupActivityHashTagLabel()
        setupActivityDescriptionLabel()
//        setupFollowerOneImageView()
    }
    
    // profileImageView corner radius implementation
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2.0
        followerOneImageView.layer.cornerRadius = followerOneImageView.bounds.width/2.0
    }
    
    // collectionView layer attributes implementation
    private func setCollectionViewAttributes() {
        activityCollectionView.addBorder(toSide: .top, withColor: UIColor.gray.cgColor, andThickness: 0.5)
        activityCollectionView.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 0.5)
    }
    
    private func setupActivityHeaderLabel() {
        addSubview(activityHeaderLabel)
        activityHeaderLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(self).offset(8)
        }
    }
    
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(activityHeaderLabel.snp.bottom).offset(10)
            make.height.equalTo(snp.height).multipliedBy(0.08)
            make.width.equalTo(profileImageView.snp.height)
        }
    }
    private func setupUsernameLabel() {
        addSubview(usernameLabel)
        usernameLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
    }
    
    private func setupTimepostedLabel() {
        addSubview(timePostedLabel)
        timePostedLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(self).offset(-8)
            make.centerY.equalTo(profileImageView.snp.centerY)
        }
    }
    
    private func setupActivityCollectionView() {
        addSubview(activityCollectionView)
        activityCollectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.height.equalTo(snp.height).multipliedBy(0.7)
        }
    }
    
    private func setupSubscribeButton() {
        addSubview(subscribeButton)
        subscribeButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(activityCollectionView.snp.trailing).offset(-10)
            make.top.equalTo(activityCollectionView.snp.top).offset(10)
        }
    }
    
    private func setupActivityHashTagLabel() {
        addSubview(activityHashTagLabel)
        activityHashTagLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(activityCollectionView.snp.bottom).offset(10)
        }
    }
    
    private func setupActivityDescriptionLabel() {
        addSubview(activityDescriptionLabel)
        activityDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(10)
            make.top.equalTo(activityHashTagLabel.snp.bottom).offset(8)
        }
    }
    
    public func sizeFollowerImagesBased(on highestFollowerCount: Int, and usersFollowers: Int) -> Double {
        let percentage = Double(usersFollowers / highestFollowerCount)
        return percentage
    }
    
//    private func setupFollowerOneImageView() {
//        addSubview(followerOneImageView)
//        followerOneImageView.snp.makeConstraints { (make) in
//            make.leading.equalTo(self).offset(8)
//            make.top.equalTo(activityDescriptionLabel.snp.bottom).offset(20)
//            make.height.equalTo(snp.height).multipliedBy(0.15)
//            make.width.equalTo(followerOneImageView.snp.height)
//        }
//    }
//
//

}



