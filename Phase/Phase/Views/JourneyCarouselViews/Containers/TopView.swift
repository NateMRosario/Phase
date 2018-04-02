//
//  TopView.swift
//  Phase
//
//  Created by Clint M on 4/2/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol TopViewDelegate: class {
    func journeyProfileImageButtonTapped()
    func journeyUserNamelabelTapped()
}

class TopView: UIViewController {
    
    
    // MARK: - Delegate
    weak var delegate: TopViewDelegate?
    
    // MARK: - Lazy variables
    // header properties
    lazy var journeyProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "g")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = bounds.width / 2
        return imageView
    }()
    
    lazy var journeyUserNamelabel: UILabel = {
        let label = UILabel()
        label.text = "Ty PodMaster"
        label.backgroundColor = UIColor.yellow
        let padding = 25
        label.textAlignment = .left
        label.backgroundColor = UIColor.white
        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
        return label
    }()
    
    lazy var journeyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.text = "Ty PodMaster. Ty PodMaster"
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return label
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
        backgroundColor = UIColor.yellow
        super.layer.borderColor = UIColor.lightGray.cgColor
        super.layer.borderWidth = 0.5
        super.makeCorner(withRadius: 10)
        setupViews()
    }
    
    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        journeyProfileImageView.makeCircle()
    }
    
    private func setupViews() {
        setupJourneyProfileImageView()
        setupJourneyUserNamelabel()
        setupJourneyDescriptionLabel()
    }
    
    
    @objc private func journeyProfileImageButtonTapped() {
        print("profile button delegate")
        delegate?.journeyProfileImageButtonTapped()
    }
    
    @objc private func journeyUserNameTapped() {
        print("journeyUserNameTapped delegate")
        delegate?.journeyUserNameTapped()
    }
    
    // MARK: - Constraints
    private func setupJourneyProfileImageView() {
        addSubview(journeyProfileImageView)
        journeyProfileImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self).offset(8)
            make.leading.equalTo(self).offset(8)
            //            make.width.equalTo(self).multipliedBy(0.25)
            make.width.equalTo(40)
            make.height.equalTo(journeyProfileImageView.snp.width)
        }
    }
    
    private func setupJourneyUserNamelabel() {
        addSubview(journeyUserNamelabel)
        journeyUserNamelabel.snp.makeConstraints { (make) in
            make.leading.equalTo(journeyProfileImageView.snp.trailing).offset(14)
            make.height.equalTo(journeyProfileImageView.snp.height).multipliedBy(0.5)
            make.top.equalTo(self).offset(8)
            make.trailing.equalTo(self).offset(-8)
        }
    }
    
    private func setupJourneyDescriptionLabel() {
        addSubview(journeyDescriptionLabel)
        journeyDescriptionLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(journeyProfileImageView.snp.trailing).offset(14)
            make.trailing.equalTo(self).offset(-8)
            make.height.equalTo(journeyProfileImageView.snp.height).multipliedBy(0.4)
            make.top.equalTo(journeyUserNamelabel.snp.bottom).offset(8)
        }
    }
    
    
}




