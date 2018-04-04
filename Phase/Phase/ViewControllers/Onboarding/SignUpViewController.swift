//
//  SignUpViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Pastel

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
        
        CognitoManager.shared.signUp(username: userName, email: email, password: password, name: fullName) { (error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                }
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Success", message: "Signed Up! Please check your email to verify.", preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Ok", style: .default) { (alert) in
                        let confirmAccountVC = ConfirmAccountViewController(username: self.userName.text!)
                        self.navigationController?.pushViewController(confirmAccountVC, animated: true)
                        //self.present(confirmAccountVC, animated: true, completion: nil)
                    }
                    alertController.addAction(okAction)
                    self.present(alertController, animated: true, completion: nil)

                }
            }
        }
    }
    @IBOutlet weak var termsAndPP: ActiveLabel!
        

    let customType = ActiveType.custom(pattern: "\\sTERMS OF USE\\b")
    let customType2 = ActiveType.custom(pattern: "\\sPRIVACY POLICY\\b")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pastelView = PastelView(frame: view.bounds)
        
        navigationController?.navigationBar.isHidden = true

        // Custom Direction
        pastelView.startPastelPoint = .topLeft
        pastelView.endPastelPoint = .bottomRight
        
        // Custom Color
        pastelView.setColors(HexStringToUIColor.appGradient)
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
        
        termsAndPP.enabledTypes.append(customType)
        termsAndPP.enabledTypes.append(customType2)
        
        termsAndPP.customize { (label) in
            label.text = "BY SIGNING UP, YOU AGREE TO OUR TERMS OF USE AND PRIVACY POLICY"

            label.handleCustomTap(for: customType) { _ in self.showAlert(title: "Terms of Use", message: "It's ya boi")}
            label.handleCustomTap(for: customType2) { _ in self.showAlert(title: "Privacy Policy", message: "AYE")}
            
            label.customColor[customType] = UIColor.white
            label.customColor[customType2] = UIColor.white
            
            label.configureLinkAttribute = { (type, attributes, isSelected) in
                var atts = attributes
                atts[NSAttributedStringKey.font] = isSelected ? UIFont.boldSystemFont(ofSize:13 ) : UIFont.boldSystemFont(ofSize: 13)
                atts[NSAttributedStringKey.underlineStyle] = 1
                return atts
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
        }
    }
}

