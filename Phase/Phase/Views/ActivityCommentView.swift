//
//  ActivityCommentView.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class ActivityCommentView: UIView {
    
    // MARK: - TableViewCell Identifier
    let cellID = "ActivityCommentTableViewCell"
    
    // MARK: - Delegate
    weak var delegate: PostCommentDelegate?
    
    // MARK: - Lazy variables
    lazy var activityCommentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(ActivityCommentTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .yellow
        return tableView
    }()
    
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "g")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.cornerRadius = bounds.width / 2
        return imageView
    }()
    
    lazy var postButton: UIButton = {
        let button = UIButton(type: UIButtonType.custom) as UIButton
        button.backgroundColor = UIColor.white
        button.setTitle("Post", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.setTitleColor(UIColor.red, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 11)
//        button.contentEdgeInsets = UIEdgeInsetsMake(2, 2, 2, 2)
        button.addTarget(self, action: #selector(postButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var commentTextField: UITextField = {
        let textfield = UITextField()
        textfield.rightView = postButton
        textfield.rightViewMode = .always
        textfield.placeholder = "Add a comment..."
        textfield.layer.cornerRadius = 14.0
        textfield.layer.borderColor = UIColor.gray.cgColor
        textfield.layer.borderWidth = 0.5
        textfield.textAlignment = .left
        textfield.layoutEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
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
    
    private func commonInit() {
        backgroundColor = UIColor.clear
        setupViews()
    }
    
    
    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.bounds.width/2.0
        commentTextField.addPadding(UITextField.PaddingSide.left(8))
    }
    
    private func setupViews() {
        setupProfileImageView()
        setupActivityCommentTableView()
        setupCommentTextField()
        addSubview(postButton)
    }
    
    @objc private func postButtonTapped() {
        print("post button delegate")
        delegate?.postButtonTapped()
    }
    
    // MARK: - Constraints
    private func setupProfileImageView() {
        addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.09)
            make.height.equalTo(profileImageView.snp.width)
            make.bottom.equalTo(self).offset(-8)
            make.leading.equalTo(self).offset(8)
        }
    }
    
    private func setupActivityCommentTableView() {
        addSubview(activityCommentTableView)
        
        activityCommentTableView.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.bottom.equalTo(profileImageView.snp.top).offset(-8)
        }
    }
    
    private func setupCommentTextField() {
        addSubview(commentTextField)
        commentTextField.snp.makeConstraints { (make) in
            make.leading.equalTo(profileImageView.snp.trailing).offset(8)
            make.trailing.equalTo(self).offset(-8)
            make.height.equalTo(profileImageView.snp.height)
            make.bottom.equalTo(profileImageView.snp.bottom)
        }
    }
    
}

// MARK: - Custom Delegate
protocol PostCommentDelegate: class {
    func postButtonTapped()
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
