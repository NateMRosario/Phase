//
//  ConfirmForgotPasswordViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/16/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class ConfirmForgotPasswordViewController: UIViewController {

    let confirmForgotPasswordView = ConfirmForgotPasswordView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(confirmForgotPasswordView)
    }

}
