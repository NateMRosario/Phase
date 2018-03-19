//
//  ActivityView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

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
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        return label
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
//        imageView.layer.cornerRadius = frame.size.width/2
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var timePostedLabel: UILabel = {
        let label = UILabel()
        label.text = "32 mins ago"
        label.textAlignment = .justified
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    lazy var activityHashTagLabel: UILabel = {
        let label = UILabel()
        label.text = "#100DaysOfCode"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var activityDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "This is my 51st day of the challenge!"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
    lazy var subscribeButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.title(for: .normal)
        button.titleLabel?.text = "Subscribe"
        button.titleColor(for: .normal)
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
        backgroundColor = UIColor.white
        setupViews()
    }
    
    // MARK: - Functions
    private func setupViews() {
        setupActivityHeaderLabel()
        setupProfileImageView()
        setupUsernameLabel()
        setupTimepostedLabel()
        setupActivityCollectionView()
        setupSubscribeButton()
//        setupActivityHashTagLabel()
//        setupActivityDescriptionLabel()
    }

    private func setupActivityHeaderLabel() {
        addSubview(activityHeaderLabel)
        activityHeaderLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
        }
    }
    
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(activityHeaderLabel.snp.bottom).offset(10)
            make.width.equalTo(self.bounds.height/4.5)
            make.height.equalTo(self.bounds.height/4.5)
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
            //            make.edges.equalTo(self)
            //            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            //            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
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
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    private func setupActivityDescriptionLabel() {
        addSubview(activityDescriptionLabel)
        activityDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    
}



