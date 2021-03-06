//JourneyAddCommentVIew.swift
//  JourneyAddCommentVIew.swift
//  Phase
//
//  Created by Clint Mejia on 3/27/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol JourneyBottomViewDelegate: class {
    func postButtonTapped()
}

class JourneyBottomView: UIView {
    
    // MARK: - Delegate
    weak var delegate: JourneyBottomViewDelegate?
    
    // MARK: - Lazy variables
    lazy var commentProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "g")
        imageView.contentMode = .scaleAspectFill
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
        textfield.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 12)
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
    
    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
    }
    
    // MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        commentProfileImageView.makeCircle()
        commentTextField.addPadding(UITextField.PaddingSide.left(8))
    }
    
    private func setupViews() {
        setupCommentProfileImageView()
        setupCommentTextField()
    }
    
    @objc private func postButtonTapped() {
        print("post button delegate")
        delegate?.postButtonTapped()
    }
    
    func updateCommentTextFieldRightView() {
        let image = postButton
        image.frame = CGRect(x: CGFloat(commentTextField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(25), height: CGFloat(25))
        //        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        //        button.frame = CGRect(x: 0, y: 0, width: 29, height: 29)
        commentTextField.rightView = image
    }
    
    // MARK: - Constraints
    private func setupCommentProfileImageView() {
        addSubview(commentProfileImageView)
        commentProfileImageView.snp.makeConstraints { (make) in
            make.width.equalTo(self).multipliedBy(0.07)
            make.height.equalTo(commentProfileImageView.snp.width)
            make.centerY.equalTo(self)
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



