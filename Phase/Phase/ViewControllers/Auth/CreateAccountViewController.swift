//
//  CreateAccountViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import AWSCognitoIdentityProvider
import AWSCognitoAuth


let CognitoIdentityUserPoolRegion: AWSRegionType = .USEast1
let CognitoIdentityUserPoolId = "us-east-1_yXNNPJ34H"
let CognitoIdentityUserPoolAppClientId = "21cf9hr5e4abibj5980pjh79sj"
let CognitoIdentityUserPoolAppClientSecret = "1csibrq3jle1d4rtnp461cm3jnnf6766vmrrtf37k52ueof07gse"

let AWSCognitoUserPoolsSignInProviderKey = "UserPool"

class CreateAccountViewController: UIViewController {

    let createAccountView = CreateAccountView()
    var pool: AWSCognitoIdentityUserPool?
    var sentTo: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(createAccountView)
        self.pool = AWSCognitoIdentityUserPool.init(forKey: AWSCognitoUserPoolsSignInProviderKey)
        setupButtons()
    }

}

extension CreateAccountViewController {
    private func setupButtons() {
        createAccountView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
    }
    
    @objc private func signUpButtonTapped() {
        guard let userNameValue = self.createAccountView.usernameTextField.text, !userNameValue.isEmpty,
            let passwordValue = self.createAccountView.passwordTextField.text, !passwordValue.isEmpty else {
                let alertController = UIAlertController(title: "Missing Required Fields",
                                                        message: "Username / Password are required for registration.",
                                                        preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                alertController.addAction(okAction)
                
                self.present(alertController, animated: true, completion:  nil)
                return
        }
        
        var attributes = [AWSCognitoIdentityUserAttributeType]()
        
        
        if let emailValue = self.createAccountView.emailTextField.text, !emailValue.isEmpty {
            let email = AWSCognitoIdentityUserAttributeType()
            email?.name = "email"
            email?.value = emailValue
            attributes.append(email!)
        }
        
        
        
        //sign up the user
        self.pool?.signUp(userNameValue, password: passwordValue, userAttributes: attributes, validationData: nil).continueWith {[weak self] (task) -> Any? in
            guard let strongSelf = self else { return nil }
            DispatchQueue.main.async(execute: {
                if let error = task.error as NSError? {
                    let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                            message: error.userInfo["message"] as? String,
                                                            preferredStyle: .alert)
                    let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                    alertController.addAction(retryAction)
                    
                    self?.present(alertController, animated: true, completion:  nil)
                } else if let result = task.result  {
                    // handle the case where user has to confirm his identity via email / SMS
                    if (result.user.confirmedStatus != AWSCognitoIdentityUserStatus.confirmed) {
                        //strongSelf.sentTo = result.codeDeliveryDetails?.destination
                        //strongSelf.performSegue(withIdentifier: "confirmSignUpSegue", sender:sender)
                        let confirmVC = ConfirmAccountViewController()
                        confirmVC.sentTo = result.codeDeliveryDetails?.destination
                        strongSelf.navigationController?.pushViewController(confirmVC, animated: true)
                    } else {
                        let _ = strongSelf.navigationController?.popToRootViewController(animated: true)
                    }
                }
                
            })
            return nil
        }
    }
}
