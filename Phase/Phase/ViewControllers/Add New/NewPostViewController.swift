//
//  NewPostViewController.swift
//  Phase
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {

    @IBOutlet weak var textfield: UITextField!
    @IBOutlet weak var label: ActiveLabel!
    @IBAction func postButton(_ sender: UIButton) {
        label.customize { (label) in
            label.text = textfield.text
            
            label.textColor = UIColor(red: 102.0/255, green: 117.0/255, blue: 127.0/255, alpha: 1)
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            label.URLColor = UIColor(red: 85.0/255, green: 238.0/255, blue: 151.0/255, alpha: 1)
            label.URLSelectedColor = UIColor(red: 82.0/255, green: 190.0/255, blue: 41.0/255, alpha: 1)
            
            label.handleMentionTap { self.alert("Mention", message: $0)}
            label.handleHashtagTap { self.alert("Hashtag", message: $0)}
            label.handleURLTap { self.alert("URL", message: $0.absoluteString)}
            
        }
        textfield.text = ""
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textfield.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func alert(_ title: String, message: String) {
        let vc = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        vc.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        present(vc, animated: true, completion: nil)
    }
}

extension NewPostViewController: UITextFieldDelegate {
    
}

extension NewPostViewController: ActiveLabelDelegate {
    func didSelect(_ text: String, type: ActiveType) {
        
    }
}
