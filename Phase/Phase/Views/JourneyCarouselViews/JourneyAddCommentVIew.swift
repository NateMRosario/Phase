//
//  JourneyAddCommentVIew.swift
//  Phase
//
//  Created by Clint Mejia on 3/27/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol JourneyPostACommentDelegate: class {
    func postButtonTapped()
}

class JourneyAddCommentVIew: UIView {
    
    // MARK: - Delegate
    weak var delegate: JourneyPostACommentDelegate?

    // MARK: - Lazy variables
    lazy var commentProfileImageView: UIImageView = {
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
        backgroundColor = UIColor.blue
        setupViews()
    }
    
    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        commentProfileImageView.layer.cornerRadius = commentProfileImageView.bounds.width/2.0
        commentTextField.addPadding(UITextField.PaddingSide.left(8))
    }
    
    private func setupViews() {
        setupCommentProfileImageView()
        setupCommentTextField()
        addSubview(postButton)
    }
    
    @objc private func postButtonTapped() {
        print("post button delegate")
        delegate?.postButtonTapped()
    }
    
    // MARK: - Constraints
    private func setupCommentProfileImageView() {
        addSubview(commentProfileImageView)
        commentProfileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.09)
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

