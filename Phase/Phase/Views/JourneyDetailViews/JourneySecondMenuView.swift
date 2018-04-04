//
//  JourneySecondMenuView.swift
//  Phase
//
//  Created by Clint Mejia on 4/3/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

// MARK: - Custom Delegate
protocol JourneySecondMenuViewDelegate: class {
    func showFollowersTapped()
}

class JourneySecondMenuView: UIView {

    // MARK: - Delegate
    weak var delegate: JourneySecondMenuViewDelegate?
    
    // MARK: - Lazy variables
    lazy var followerThinButton: UIButton = {
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
        button.addTarget(self, action: #selector(showFollowersTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var followersLabel: UIButton = {
        let button = UIButton()
        button.setTitle("Followers", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = UIColor.clear
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        button.addTarget(self, action: #selector(showFollowersTapped), for: .touchUpInside)
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
    
    // MARK: - Functions
    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
    }
    
    private func setupViews() {
        setFollowerThinButtonConstraints()
        setFollowersLabelConstraints()
    }
    
    @objc func showFollowersTapped() {
        print("show followers tapped")
        delegate?.showFollowersTapped()
    }
    
    // MARK: - Constraints
    private func setFollowerThinButtonConstraints() {
        addSubview(followerThinButton)
        followerThinButton.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(10)
            make.centerX.equalTo(self)
            make.height.equalTo(5)
            make.width.equalTo(self).multipliedBy(0.19)
        }
    }
    
    private func setFollowersLabelConstraints() {
        addSubview(followersLabel)
        followersLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(self).offset(-2)
            make.leading.equalTo(self).offset(12)
            make.trailing.equalTo(self).offset(-12)
        }
    }

}
