//
//  JourneyCommentTableView.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol JourneyEventDetailViewDelegate: class {
    func replyButtonTapped()
    func journeyProfileImageButtonTapped()
    func postButtonTapped()
}

class JourneyEventDetailView: UIView {
    
    // MARK: - TableViewCell Identifier
    let cellID = "JourneyCommentTableViewCell"
    
    // MARK: - Delegate
    weak var delegate: JourneyEventDetailViewDelegate?
    
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
    
    // tableView properties
    lazy var journeyCommentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(JourneyCommentTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .white
        tableView.layer.borderColor = UIColor.lightGray.cgColor
        tableView.layer.borderWidth = 0.5
        return tableView
    }()
    
    // footer properties
    lazy var commentProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "g")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = bounds.width / 2
        return imageView
    }()
    
    lazy var postButton: UIButton = {
//        let button = UIButton(type: UIButtonType.custom) as UIButton
        let button = UIButton(frame: CGRect(x: 100, y: 0, width: 20, height: 20))
        button.backgroundColor = UIColor.white
        button.setTitle("Post", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var commentTextField: UITextField = {
        let textfield = UITextField()
        //        textfield.rightView = postButton
        textfield.rightViewMode = .always
        textfield.placeholder = "Add a comment..."
        textfield.layer.cornerRadius = 14.0
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.layer.borderWidth = 0.5
        textfield.textAlignment = .left
        textfield.layoutEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 25)
        let view = UIView(frame: CGRect(x: 100, y: 0, width: CGFloat(20), height: CGFloat(20)))
        view.addSubview(postButton)
        textfield.rightView = view
        return textfield
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
        super.layer.borderColor = UIColor.lightGray.cgColor
        super.layer.borderWidth = 0.5
        super.makeCorner(withRadius: 10)
        setupViews()
        updateCommentTextFieldRightView()
    }
    
    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        journeyProfileImageView.makeCircle()
        commentProfileImageView.makeCircle()
        commentTextField.addPadding(UITextField.PaddingSide.left(8))
    }
    
    private func setupViews() {
        setupJourneyProfileImageView()
        setupJourneyUserNamelabel()
        setupJourneyDescriptionLabel()
        setupCommentProfileImageView()
        setupCommentTextField()
        setupJourneyCommentTableViewConstraints()
        addSubview(postButton)
    }
    
    func updateCommentTextFieldRightView() {
        let image = postButton
        image.frame = CGRect(x: CGFloat(commentTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        //        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        //        button.frame = CGRect(x: 0, y: 0, width: 29, height: 29)
        commentTextField.rightView = image
    }
    
    @objc private func journeyProfileImageButtonTapped() {
        print("profile button delegate")
        delegate?.journeyProfileImageButtonTapped()
    }
    
    @objc private func replyButtonTapped() {
        print("reply button delegate")
        delegate?.replyButtonTapped()
    }
    
    @objc private func postButtonTapped() {
        print("post button delegate")
        delegate?.postButtonTapped()
    }
    
    public func isViewHidden(_ state: Bool) {
        guard state == false else {
            journeyCommentTableView.isHidden = true
            commentProfileImageView.isHidden = true
            commentTextField.isHidden = true
            return
        }
        journeyCommentTableView.isHidden = false
        commentProfileImageView.isHidden = false
        commentTextField.isHidden = false
        return
    }
    
    // MARK: - Constraints
    // header constraints
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
    
    
    // tableview constraints
    private func setupJourneyCommentTableViewConstraints() {
        addSubview(journeyCommentTableView)
        journeyCommentTableView.snp.makeConstraints { (make) in
            make.top.equalTo(journeyProfileImageView.snp.bottom).offset(25)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.bottom.equalTo(commentProfileImageView.snp.top).offset(-15)
        }
    }
    
    // footer constraints
    private func setupCommentProfileImageView() {
        addSubview(commentProfileImageView)
        commentProfileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.085)
            make.height.equalTo(commentProfileImageView.snp.width)
            make.bottom.equalTo(self).offset(-8)
            make.leading.equalTo(self).offset(8)
        }
    }
    
    private func setupCommentTextField() {
        addSubview(commentTextField)
        commentTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(commentProfileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(self).offset(-8)
            make.height.equalTo(commentProfileImageView.snp.height)
            make.bottom.equalTo(commentProfileImageView.snp.bottom)
        }
    }
    
}

extension UITextField {
    
    enum PaddingSide {
        case left(CGFloat)
        case right(CGFloat)
        case both(CGFloat)
    }
    
    func addPadding(_ padding: PaddingSide) {
        
        self.leftViewMode = .always
        self.layer.masksToBounds = true
        
        
        switch padding {
            
        case .left(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.leftView = paddingView
            self.rightViewMode = .always
            
        case .right(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            self.rightView = paddingView
            self.rightViewMode = .always
            
        case .both(let spacing):
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: spacing, height: self.frame.height))
            // left
            self.leftView = paddingView
            self.leftViewMode = .always
            // right
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
}



