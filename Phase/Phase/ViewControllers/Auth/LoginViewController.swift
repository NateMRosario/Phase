//
//  LoginViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import AMPopTip
import AWSCore
import AWSCognitoIdentityProvider
import AWSCognitoAuth


class LoginViewController: UIViewController {

    let loginView = LoginView()
    let popTip = PopTip()
    var passwordAuthenticationCompletion: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>?
    var usernameText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(loginView)
        loginView.emailTextField.delegate = self
        loginView.passwordTextField.delegate = self
        setupButtons()
    }

}

// MARK: - Setup Buttons
extension LoginViewController {
    private func setupButtons() {
        loginView.signInButton.addTarget(self, action: #selector(signInButtonTapped), for: .touchUpInside)
        loginView.createAccountButton.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        loginView.forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordButtonTapped), for: .touchUpInside)
    }

    @objc private func signInButtonTapped() {
        if (self.loginView.usernameTextField.text != nil && self.loginView.passwordTextField.text != nil) {
            let authDetails = AWSCognitoIdentityPasswordAuthenticationDetails(username: self.loginView.usernameTextField.text!, password: self.loginView.passwordTextField.text! )
            self.passwordAuthenticationCompletion?.set(result: authDetails)
        } else {
            let alertController = UIAlertController(title: "Missing information",
                                                    message: "Please enter a valid user name and password",
                                                    preferredStyle: .alert)
            let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
            alertController.addAction(retryAction)
        }
    }
    
    @objc private func createAccountButtonTapped() {
        let createAccountViewController = CreateAccountViewController()
        navigationController?.pushViewController(createAccountViewController, animated: true)
    }
    
    @objc private func forgotPasswordButtonTapped() {
        let forgotPasswordViewController = ForgotPasswordViewController()
        navigationController?.pushViewController(forgotPasswordViewController, animated: true)
    }
}

// MARK: - Text Field Delegates
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == loginView.emailTextField {
            popTip.show(text: "ITS YO BOY POP TIP", direction: .up, maxWidth: 200, in: view, from: textField.frame)
            
            
        } else if textField == loginView.passwordTextField {
            popTip.show(text: "please enter 8-20 characters \n include at least one uppercase letter \n one number \n and one special character (!@$)", direction: .up, maxWidth: 200, in: view, from: textField.frame)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension LoginViewController: AWSCognitoIdentityPasswordAuthentication {
    
    public func getDetails(_ authenticationInput: AWSCognitoIdentityPasswordAuthenticationInput, passwordAuthenticationCompletionSource: AWSTaskCompletionSource<AWSCognitoIdentityPasswordAuthenticationDetails>) {
        self.passwordAuthenticationCompletion = passwordAuthenticationCompletionSource
        DispatchQueue.main.async {
            if (self.usernameText == nil) {
                self.usernameText = authenticationInput.lastKnownUsername
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    public func didCompleteStepWithError(_ error: Error?) {
        DispatchQueue.main.async {
            if let error = error as NSError? {
                let alertController = UIAlertController(title: error.userInfo["__type"] as? String,
                                                        message: error.userInfo["message"] as? String,
                                                        preferredStyle: .alert)
                let retryAction = UIAlertAction(title: "Retry", style: .default, handler: nil)
                alertController.addAction(retryAction)
                
                self.present(alertController, animated: true, completion:  nil)
            } else {
                self.loginView.usernameTextField.text = nil
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
}

