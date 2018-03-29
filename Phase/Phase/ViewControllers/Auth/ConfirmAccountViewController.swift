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
    var sentTo: String?
    
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
    }


}

extension ConfirmAccountViewController {
    private func setupButtons() {
        confirmAccountView.confirmAccountButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        confirmAccountView.resendButton.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
    }
    
    @objc private func confirmButtonTapped() {

    }
    
    // handle code resend action
    @objc private func resendButtonTapped() {

    }
}
