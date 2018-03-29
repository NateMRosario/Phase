////
////  JourneyHeaderTableViewCell.swift
////  Phase
////
////  Created by Clint Mejia on 3/28/18.
////  Copyright © 2018 Reiaz Gafar. All rights reserved.
////
//
//import UIKit
//import SnapKit
//
//// MARK: - Custom Delegate
//protocol JourneyHeaderDelegate: class {
//    func journeyProfileImageButtonTapped()
//}
//
//class JourneyHeaderTableViewCell: UITableViewCell {
//    
//    //MARK: - TableViewCell Identifier
//    let cellID = "JourneyHeaderTableViewCell"
//    
//    // MARK: - Delegate
//    weak var delegate: JourneyHeaderDelegate?
//    
//    // MARK: - Lazy variables
//    lazy var journeyProfileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "g")
//        imageView.contentMode = .scaleAspectFit
//        imageView.layer.masksToBounds = true
//        imageView.clipsToBounds = true
//        imageView.layer.borderWidth = 0.5
//        imageView.layer.borderColor = UIColor.gray.cgColor
//        imageView.layer.cornerRadius = bounds.width / 2
//        return imageView
//    }()
//    
//    lazy var journeyUserNamelabel: UILabel = {
//        let label = UILabel()
//        label.text = "Ty PodMaster"
//        label.textAlignment = .left
//        label.backgroundColor = UIColor.green
//        label.font = UIFont.systemFont(ofSize: 16, weight: .heavy)
//        return label
//    }()
//    
//    lazy var journeyDescriptionLabel: UILabel = {
//        let label = UILabel()
//        label.backgroundColor = UIColor.green
//        label.text = "Ty PodMaster. Ty PodMaster"
//        label.textAlignment = .left
//        label.font = UIFont.systemFont(ofSize: 12, weight: .regular)
//        return label
//    }()
//    
//    // MARK: - Initializers
//    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        commonInit()
//        setupView()
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        backgroundColor = .red
//    }
//    
//    // MARK: - Functions
//    private func commonInit() {
//        backgroundColor = UIColor.red
//    }
//    
//    // MARK: - Functions
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        journeyProfileImageView.layer.cornerRadius = journeyProfileImageView.bounds.width/2.0
//    }
//    
//    private func setupView() {
//        setupJourneyProfileImageView()
//        setupJourneyUserNamelabel()
//        setupJourneyDescriptionLabel()
//    }
//    
//    @objc private func journeyProfileImageButtonTapped() {
//        print("profile button delegate")
//        delegate?.journeyProfileImageButtonTapped()
//    }
//    
//    // MARK: - Constraints
//    private func setupJourneyProfileImageView() {
//        addSubview(journeyProfileImageView)
//        journeyProfileImageView.snp.makeConstraints { (make) in
//            make.width.equalTo(self).multipliedBy(0.3)
//            make.height.equalTo(journeyProfileImageView.snp.width)
//            make.top.equalTo(self).offset(8)
//            make.leading.equalTo(self).offset(8)
//        }
//    }
//    
//    private func setupJourneyUserNamelabel() {
//        addSubview(journeyUserNamelabel)
//        journeyUserNamelabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(journeyProfileImageView.snp.trailing).offset(14)
//            make.height.equalTo(journeyProfileImageView.snp.height).multipliedBy(0.5)
//            make.top.equalTo(self).offset(8)
//            make.trailing.equalTo(self).offset(-8)
//        }
//    }
//    
//    private func setupJourneyDescriptionLabel() {
//        addSubview(journeyDescriptionLabel)
//        journeyDescriptionLabel.snp.makeConstraints { (make) in
//            make.leading.equalTo(journeyProfileImageView.snp.trailing).offset(14)
//            make.trailing.equalTo(self).offset(-8)
//            make.height.equalTo(journeyProfileImageView.snp.height).multipliedBy(0.4)
//            make.top.equalTo(journeyUserNamelabel.snp.bottom).offset(8)
//        }
//    }
//}
//
