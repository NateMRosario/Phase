//
//  LoginView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField
import AMPopTip
import AWSCognitoIdentityProvider


class LoginView: UIView {
    
    // MARK: - Properties
    let systemBlue = UIColor(displayP3Red: 27/255, green: 173/255, blue: 248/255, alpha: 1)

    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.image = #imageLiteral(resourceName: "violet1")
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "KAWAII DESU"
        return label
    }()
    
    lazy var usernameTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.placeholder = "Username"
        textField.title = "Username"
        textField.tintColor = .blue // the color of the blinking cursor
        textField.textColor = .darkGray
        textField.lineColor = .darkGray
        textField.selectedTitleColor = .blue
        textField.selectedLineColor = .blue
        textField.lineHeight = 1.0 // bottom line height in points
        textField.selectedLineHeight = 2.0
        
        textField.iconType = IconType.image
        textField.iconImage = #imageLiteral(resourceName: "iconProfile")
        textField.iconColor = systemBlue
        textField.selectedIconColor = .blue
        textField.iconMarginBottom = 2
        textField.iconRotationDegrees = 0 // rotate it 90 degrees
        textField.iconMarginLeft = 6
        return textField
    }()
    
    lazy var emailTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.placeholder = "Email"
        textField.title = "Email Address"
        textField.tintColor = .blue // the color of the blinking cursor
        textField.textColor = .darkGray
        textField.lineColor = .darkGray
        textField.selectedTitleColor = .blue
        textField.selectedLineColor = .blue
        textField.lineHeight = 1.0 // bottom line height in points
        textField.selectedLineHeight = 2.0
        
        textField.iconType = IconType.image
        textField.iconImage = #imageLiteral(resourceName: "iconEmail")
        textField.iconColor = systemBlue
        textField.selectedIconColor = .blue
        textField.iconMarginBottom = 2
        textField.iconRotationDegrees = 0 // rotate it 90 degrees
        textField.iconMarginLeft = 6
        return textField
    }()
    
    lazy var passwordTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        
        textField.placeholder = "Password"
        textField.title = "Please enter a valid password"
        textField.tintColor = .blue // the color of the blinking cursor
        textField.textColor = .darkGray
        textField.lineColor = .darkGray
        textField.selectedTitleColor = .blue
        textField.selectedLineColor = .blue
        textField.lineHeight = 1.0 // bottom line height in points
        textField.selectedLineHeight = 2.0
        
        textField.iconType = IconType.image
        textField.iconImage = #imageLiteral(resourceName: "iconKey")
        textField.iconColor = systemBlue
        textField.selectedIconColor = .blue
        textField.iconMarginBottom = 2 // more precise icon positioning. Usually needed to tweak on a per font basis.
        textField.iconRotationDegrees = 0 // rotate it 90 degrees
        textField.iconMarginLeft = 6
        
        return textField
    }()
    
    lazy var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create Account", for: .normal)
        button.setTitleColor(systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
        button.setTitleColor(systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        return button
    }()
    
    // MARK: - Inits
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupLogoImageView()
        setupTitleLabel()
        setupUsernameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupSignInButton()
        setupCreateAccountButton()
        setupForgotPasswordButton()
    }

}

// MARK: - Autolayout
extension LoginView {
    private func setupLogoImageView() {
        addSubview(logoImageView)
        logoImageView.snp.makeConstraints { (make) in
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.bottom.equalTo(safeAreaLayoutGuide.snp.centerY)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
            make.height.equalTo(logoImageView.snp.width)
        }
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(logoImageView.snp.bottom)
            make.width.equalTo(logoImageView.snp.width)
            make.centerX.equalTo(logoImageView.snp.centerX)
        }
    }
    
    private func setupUsernameTextField() {
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.width.equalTo(logoImageView.snp.width)
            make.centerX.equalTo(logoImageView.snp.centerX)
        }
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(6)
            make.width.equalTo(logoImageView.snp.width)
            make.centerX.equalTo(logoImageView.snp.centerX)
        }
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(6)
            make.width.equalTo(emailTextField.snp.width)
            make.centerX.equalTo(emailTextField.snp.centerX)
        }
    }
    
    private func setupSignInButton() {
        addSubview(signInButton)
        signInButton.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(12)
            make.width.equalTo(emailTextField.snp.width)
            make.centerX.equalTo(emailTextField.snp.centerX)
        }
    }
    
    private func setupCreateAccountButton() {
        addSubview(createAccountButton)
        createAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(signInButton.snp.bottom).offset(6)
            make.leading.equalTo(signInButton.snp.leading)
        }
    }
    
    private func setupForgotPasswordButton() {
        addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints { (make) in
            make.top.equalTo(signInButton.snp.bottom).offset(6)
            make.trailing.equalTo(signInButton.snp.trailing)
        }
    }
}
