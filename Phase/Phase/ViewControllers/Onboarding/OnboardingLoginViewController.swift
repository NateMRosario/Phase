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
        CognitoManager.shared.signIn(username: userLoginInfoTF.text ?? "", password: passwordTF.text ?? "")
        
        self.present(TabsViewController.instantiate(withStoryboard: "Main"), animated: true, completion: nil)
    }
    
    @IBOutlet weak var userLoginInfoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
