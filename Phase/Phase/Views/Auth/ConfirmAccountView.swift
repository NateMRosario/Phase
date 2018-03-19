//
//  ConfirmAccountView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/16/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ConfirmAccountView: UIView {
    
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
        textField.iconImage = #imageLiteral(resourceName: "iconEmail")
        textField.iconColor = systemBlue
        textField.selectedIconColor = .blue
        textField.iconMarginBottom = 2
        textField.iconRotationDegrees = 0 // rotate it 90 degrees
        textField.iconMarginLeft = 6
        return textField
    }()
    
    lazy var confirmationCodeTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.placeholder = "Confirmation Code"
        textField.title = "Confirmation Code"
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
    
    lazy var confirmAccountButton: UIButton = {
        let button = UIButton()
        button.setTitle("Confirm Account", for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        return button
    }()
    
    lazy var resendButton: UIButton = {
        let button = UIButton()
        button.setTitle("resend confirmation code", for: .normal)
        button.setTitleColor(systemBlue, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
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
        setupConfirmationCodeTextField()
        setupConfirmAccountButton()
        setupResendButton()
    }

}

extension ConfirmAccountView {
    private func setupUsernameTextField() {
        addSubview(usernameTextField)
        usernameTextField.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).offset(12)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
    
    private func setupConfirmationCodeTextField() {
        addSubview(confirmationCodeTextField)
        confirmationCodeTextField.snp.makeConstraints { (make) in
            make.top.equalTo(usernameTextField.snp.bottom).offset(6)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
    
    private func setupConfirmAccountButton() {
        addSubview(confirmAccountButton)
        confirmAccountButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmationCodeTextField.snp.bottom).offset(6)
            make.centerX.equalTo(safeAreaLayoutGuide.snp.centerX)
            make.width.equalTo(safeAreaLayoutGuide.snp.width).multipliedBy(0.90)
        }
    }
    
    private func setupResendButton() {
        addSubview(resendButton)
        resendButton.snp.makeConstraints { (make) in
            make.top.equalTo(confirmAccountButton.snp.bottom).offset(6)
            make.leading.equalTo(confirmAccountButton.snp.leading)
        }
    }
    
}
