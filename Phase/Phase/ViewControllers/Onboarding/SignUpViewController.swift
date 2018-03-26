//
//  SignUpViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBAction func backButton(_ sender: UIButton) {dismiss(animated: true)}
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func signUp(_ sender: UIButton) {
        guard let userName = userName.text else { return }
        guard let email = email.text else {return}
        guard let fullName = fullName.text else {return}
        guard let password = password.text else {return}
        
        CognitoManager.shared.signUp(username: userName, email: email, password: password) { (error) in
            if let error = error {
                self.showAlert(title: "Error", message: "\(error.localizedDescription)")
            } else {
                self.showAlert(title: "Success", message: "Signed Up! Please check your email to verify.")
            }
        }
    }
    @IBOutlet weak var termsAndPP: ActiveLabel!
    
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    let customType = ActiveType.custom(pattern: "\\sTERMS OF USE\\b")
    let customType2 = ActiveType.custom(pattern: "\\sPRIVATE POLICY\\b")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        termsAndPP.enabledTypes.append(customType)
        termsAndPP.enabledTypes.append(customType2)
        
        termsAndPP.customize { (label) in
            label.text = "BY SIGNING UP, YOU AGREE TO OUR TERMS OF USE AND PRIVATE POLICY"
            label.handleCustomTap(for: customType) { _ in self.showAlert(title: "Terms of Use", message: "It's ya boi")}
            label.handleCustomTap(for: customType2) { _ in self.showAlert(title: "Private Policy", message: "ayye lmfao")}
            
            label.customColor[customType] = UIColor.white
            label.customColor[customType2] = UIColor.white
            
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                atts[NSAttributedStringKey.font] = isSelected ? UIFont.boldSystemFont(ofSize:13 ) : UIFont.boldSystemFont(ofSize: 13)
                return atts
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
