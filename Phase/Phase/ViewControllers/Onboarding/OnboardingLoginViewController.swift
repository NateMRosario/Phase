//
//  OnboardingLoginViewController.swift
//  Phase
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Pastel

class OnboardingLoginViewController: UIViewController {
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true)
    }
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        guard let userInfo = userLoginInfoTF.text else { return }
        guard let password = passwordTF.text else { return }

        CognitoManager.shared.signIn(username: userInfo , password: password) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "\(error.localizedDescription)")
            } else {
                self.present(TabsViewController.instantiate(withStoryboard: "Main"), animated: true, completion: nil)
            }
        }
    }
    
    @IBOutlet weak var userLoginInfoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            DispatchQueue.main.async {
                self.userLoginInfoTF.resignFirstResponder()
                self.passwordTF.resignFirstResponder()
            }
        }
    }
}
