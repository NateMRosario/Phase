//
//  JourneyCommentTableViewCell.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class JourneyCommentTableViewCell: UITableViewCell {
    
    // MARK: - Delegate
        weak var delegate: JourneyCommentTableCellDelegate?
    
    //    private var post: Post!
    
    // MARK: - Outlets
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "7-R5CLfl_400x400")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        return imageView
    }()
    
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "This is a comment. This is a comment. This is a comment. This is a comment. This is a comment. This is a comment. "
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font.withSize(13)
        return label
    }()
    
    lazy var timePostedLabel: UILabel = {
        let label = UILabel()
        label.text = "2h"
        label.textAlignment = .left
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        return label
    }()
    
    lazy var replyButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.setTitle("Reply", for: .normal)
        button.titleLabel?.textAlignment = .left
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 11, weight: .light)
        button.addTarget(self, action: #selector(replyButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Initializers
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        backgroundColor = .red
    }
    
    // MARK: - Functions
    private func setUpView() {
        setupProfileImageView()
        setupTimePostedLabel()
        setupCommentLabel()
        setupReplyButton()
    }
    
    // profileImageView corner radius implementation
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.makeCircle()
    }
    
    
    @objc private  func profileImageTapped(sender: UIImageView, target:UIViewController) {
        print("profile image delegate")
        delegate?.profileImageTapped()
    }
    
    @objc private func replyButtonTapped() {
        print("reply button delegate")
        delegate?.replyButtonTapped()
    }
    
    // MARK: - Constraints
    // refer to cell height for image size, not width (eg self)
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(profileImageView.snp.width)
            make.leading.equalTo(self).offset(8)
            make.top.equalTo(self).offset(8)
        }
    }
    
    private func setupTimePostedLabel() {
        addSubview(timePostedLabel)
        timePostedLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(14)
            make.bottom.equalTo(self).offset(-8)
        }
    }
    
    private func setupReplyButton() {
        addSubview(replyButton)
        replyButton.snp.makeConstraints { (make) in
            make.leading.equalTo(timePostedLabel.snp.trailing).offset(12)
            make.firstBaseline.equalTo(timePostedLabel.snp.firstBaseline).offset(6)
            make.bottom.equalTo(self).offset(-8)
        }
    }
    
    private func setupCommentLabel() {
        addSubview(commentLabel)
        commentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(profileImageView.snp.top).offset(2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(14)
            make.trailing.equalTo(self).offset(-12)
            make.bottom.equalTo(timePostedLabel.snp.top).offset(-10)
        }
    }
    
    
    public func configureCell(with event: EventDummyDate) {
        let formattedString = NSMutableAttributedString()
        formattedString.bold("\(event._userId):  ")
        formattedString.normal(" \(event._caption)")
        
        self.profileImageView.image = UIImage(imageLiteralResourceName: "\(event._media)")
        self.timePostedLabel.text = event._eventId
        self.commentLabel.attributedText = formattedString
    }
    
}

// MARK: - Custom Delegate
protocol JourneyCommentTableCellDelegate: class {
    func profileImageTapped()
    func replyButtonTapped()
}
