//
//  ConfirmAccountViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/16/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import AWSCognitoAuth
import Pastel


class ConfirmAccountViewController: UIViewController {

    let confirmAccountView = ConfirmAccountView()
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(confirmAccountView)
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .topLeft
        pastelView.endPastelPoint = .bottomRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors(HexStringToUIColor.appGradient)
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        setupButtons()
        confirmAccountView.userNameLabel.text = username
    }
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
        }
    }
}

extension ConfirmAccountViewController {
    private func setupButtons() {
        confirmAccountView.confirmAccountButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        confirmAccountView.resendButton.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
    }
    
    @objc private func confirmButtonTapped() {
        
        guard let code = confirmAccountView.confirmationCodeTextField.text else { return }
        guard code.count > 0 else { showAlert(title: "Error", message: "Please enter a valid code."); return }
        
        CognitoManager.shared.confirmAccount(username: username, code: code) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "\(error)")
                }
            } else {
                self.motionUnwindToRootViewController()
            }
        }
    }
    
    // handle code resend action
    @objc private func resendButtonTapped() {
        CognitoManager.shared.resendCode(username: username) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "\(error)")
                }
            }
        }
    }
}
