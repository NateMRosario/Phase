//
//  ConfirmForgotPasswordView.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/16/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ConfirmForgotPasswordView: UIView {

    // MARK: - Properties
    let systemBlue = UIColor(displayP3Red: 27/255, green: 173/255, blue: 248/255, alpha: 1)
    
    lazy var confirmationCodeTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.placeholder = "Confirmation Code"
        textField.title = "Confirmation Code"
        textField.errorMessage = "Invalid Code"
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
    
    lazy var newPasswordTextField: SkyFloatingLabelTextFieldWithIcon = {
        let textField = SkyFloatingLabelTextFieldWithIcon()
        
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        
        textField.placeholder = "New Password"
        textField.title = "New Password"
        textField.errorMessage = "Invalid Password"
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
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("Forgot Password", for: .normal)
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
    }

}
