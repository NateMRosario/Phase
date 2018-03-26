//
//  OnboardingLoginViewController.swift
//  Phase
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class OnboardingLoginViewController: UIViewController {
    
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
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            userLoginInfoTF.resignFirstResponder()
            passwordTF.resignFirstResponder()
        }
    }
}
