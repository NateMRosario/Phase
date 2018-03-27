//
//  ForgotPassViewController.swift
//  Phase
//
//  Created by C4Q on 3/24/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Pastel

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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    deinit {
        print("ForgotPassViewController")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            DispatchQueue.main.async {
                self.emailTextField.resignFirstResponder()
            }
        }
    }
}

