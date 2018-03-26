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
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        print("ForgotPassViewController")
    }
}
