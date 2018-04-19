//
//  CreateAccountView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit
import SkyFloatingLabelTextField

class CreateAccountView: UIView {

    // MARK: - Properties
    let systemBlue = UIColor(displayP3Red: 27/255, green: 173/255, blue: 248/255, alpha: 1)
    
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
        textField.keyboardType = .emailAddress
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
    
    lazy var confirmPasswordTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        
        textField.placeholder = "Verify Password"
        textField.title = "Please make sure both passwords are the same"
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
    
    lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
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
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupUsernameTextField()
        setupEmailTextField()
        setupPasswordTextField()
        setupConfirmPasswordTextField()
        setupSignUpButton()
    }

}

extension CreateAccountView {
    private func setupUsernameTextField() {
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
    
    private func setupEmailTextField() {
        addSubview(emailTextField)
        emailTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(6)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
    
    private func setupPasswordTextField() {
        addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(emailTextField.snp.bottom).offset(6)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
    
    private func setupConfirmPasswordTextField() {
        addSubview(confirmPasswordTextField)
        confirmPasswordTextField.snp.makeConstraints { (make) in
            make.top.equalTo(passwordTextField.snp.bottom).offset(6)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
    
    private func setupSignUpButton() {
        addSubview(signUpButton)
        signUpButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmPasswordTextField.snp.bottom).offset(6)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
}
