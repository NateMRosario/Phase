//
//  ForgotPassViewController.swift
//  Phase
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class ForgotPassViewController: UIViewController {

    @IBAction func backToLogin(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBAction func sendResetEmailButton(_ sender: UIButton) {
        guard let userInfo = emailTextField.text else {return}
        CognitoManager.shared.forgotPassword(username: userInfo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("ForgotPassViewController")
    }
}

