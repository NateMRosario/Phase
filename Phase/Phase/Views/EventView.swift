//
//  ActivityView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// Selective border extension - top, bottom, leading or trailing.
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

class EventView: UIView {
    
    // Custom Delegate
    weak var delegate: EventViewDelegate?
    
    // Cell Identifier
    let collectionViewCellID = "EventCollectionViewCell"
    
    // MARK: - Lazy variables
    lazy var eventCollectionView: UICollectionView = {
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
        collectionView.register(EventCollectionViewCell.self, forCellWithReuseIdentifier: collectionViewCellID)
        return collectionView
    }()
    
    lazy var eventHeaderLabel: UILabel = {
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
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(userNameLabelTapped))
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
    
    lazy var eventHashTagLabel: UILabel = {
        let label = UILabel()
        label.text = "#100DaysOfCode"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(eventHashTagLabelTapped))
        return label
    }()
    
    lazy var eventDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is my 51st day of the challenge!"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.darkGray
        label.isUserInteractionEnabled = true
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(eventDescriptionLabelTapped))
        return label
    }()
    
    lazy var subscribeButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.backgroundColor = UIColor.blue
        button.setTitle("Subscribe", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8)
        button.addTarget(self, action: #selector(subscribeButtonPressed), for: .touchUpInside)
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
//    let followersView = FollowersView()
    
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
        setupEventHeaderLabel()
        setupProfileImageView()
        setupUsernameLabel()
        setupTimepostedLabel()
        setupEventCollectionView()
        setupSubscribeButton()
        setupEventHashTagLabel()
        setupEventDescriptionLabel()
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
        eventCollectionView.addBorder(toSide: .top, withColor: UIColor.gray.cgColor, andThickness: 0.5)
        eventCollectionView.addBorder(toSide: .bottom, withColor: UIColor.gray.cgColor, andThickness: 0.5)
    }
    
    @objc public func profileImageTapped(sender: UIImageView, target:UIViewController) {
        print("profile image delegate")
        delegate?.profileImagePressed()
    }
    
    @objc public func subscribeButtonPressed(sender: UIImageView, target:UIViewController) {
        print("userName delegate")
        delegate?.subscribeButtonPressed()
    }
    
    @objc public func userNameLabelTapped(sender: UIImageView, target:UIViewController) {
        print("userNameLabelTapped")
        delegate?.userNameLabelTapped()
    }
    
    @objc public func eventHashTagLabelTapped(sender: UIImageView, target:UIViewController) {
        print("eventHashTagLabelTapped")
        delegate?.eventHashTagLabelTapped()
    }
    
    @objc public func eventDescriptionLabelTapped(sender: UIImageView, target:UIViewController) {
        print("eventDescriptionLabelTapped")
        delegate?.eventDescriptionLabelTapped()
    }
    
    // MARK: - Constraints
    private func setupEventHeaderLabel() {
        addSubview(eventHeaderLabel)
        eventHeaderLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(self).offset(8)
        }
    }
    
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(eventHeaderLabel.snp.bottom).offset(10)
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
    
    private func setupEventCollectionView() {
        addSubview(eventCollectionView)
        eventCollectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.height.equalTo(snp.height).multipliedBy(0.7)
        }
    }
    
    private func setupSubscribeButton() {
        addSubview(subscribeButton)
        subscribeButton.snp.makeConstraints { (make) in
            make.trailing.equalTo(eventCollectionView.snp.trailing).offset(-10)
            make.top.equalTo(eventCollectionView.snp.top).offset(10)
        }
    }
    
    private func setupEventHashTagLabel() {
        addSubview(eventHashTagLabel)
        eventHashTagLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(eventCollectionView.snp.bottom).offset(10)
        }
    }
    
    private func setupEventDescriptionLabel() {
        addSubview(eventDescriptionLabel)
        eventDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(10)
            make.top.equalTo(eventHashTagLabel.snp.bottom).offset(8)
        }
    }
    
//    public func sizeFollowerImagesBased(on highestFollowerCount: Int, and usersFollowers: Int) -> Double {
//        let percentage = Double(usersFollowers / highestFollowerCount)
//        return percentage
//    }

}


protocol EventViewDelegate: class {
    func profileImagePressed()
    func subscribeButtonPressed()
    func userNameLabelTapped()
    func eventHashTagLabelTapped()
    func eventDescriptionLabelTapped()
}


