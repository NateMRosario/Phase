//
//  ConfirmAccountView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/16/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Material

class ConfirmAccountView: UIView {
    
    // MARK: - Properties
    lazy var containerView: UIView = {
        let container = UIView()
        container.backgroundColor = .clear
        return container
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.font = UIFont.systemFont(ofSize: 24)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    lazy var confirmationCodeTextField: TextField = {
        let textField = TextField()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.placeholder = "Confirmation Code"
        textField.textColor = .white
        textField.isClearIconButtonEnabled = true
        textField.tintColor = .white // the color of the blinking cursor
        textField.font = UIFont.systemFont(ofSize: 20)
        textField.keyboardType = .default
        let leftView = UIImageView()
        leftView.image = #imageLiteral(resourceName: "edit")
        textField.leftView = leftView
        return textField
    }()
    
    lazy var confirmAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm Account", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    lazy var resendButton: UIButton = {
        let button = UIButton()
        button.setTitle("Resend Code", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .green
        setupViews()
    }
    
    private func setupViews() {
        setupContainerView()
        setupUserNameLabel()
        setupConfirmationCodeTextField()
        setupConfirmAccountButton()
        setupResendButton()
    }
    
    // Mark:- Constraints
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.8),
            containerView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.7),
            containerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
    private func setupUserNameLabel() {
        addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor),
            userNameLabel.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            userNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupConfirmationCodeTextField() {
        addSubview(confirmationCodeTextField)
        confirmationCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmationCodeTextField.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 40),
            confirmationCodeTextField.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            confirmationCodeTextField.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupConfirmAccountButton() {
        addSubview(confirmAccountButton)
        confirmAccountButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            confirmAccountButton.topAnchor.constraint(equalTo: confirmationCodeTextField.bottomAnchor, constant: 20),
            confirmAccountButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            confirmAccountButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupResendButton() {
        addSubview(resendButton)
        resendButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            resendButton.topAnchor.constraint(equalTo: confirmAccountButton.bottomAnchor, constant: 8),
            resendButton.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            resendButton.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
}
