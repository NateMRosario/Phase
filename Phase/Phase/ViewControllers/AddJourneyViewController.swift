//
//  AddJourneyViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class AddJourneyViewController: UIViewController {
    
    let addJourneyView = AddJourneyView()
    let imagePreview = CapturedImageView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addJourneyView)
        addJourneyView.newJourneyNameTextField.delegate = self
        addJourneyView.newJourneyDescriptionTextView.delegate = self
        addJourneyView.cancelButton.addTarget(self,
                                              action: #selector(cancel),
                                              for: .touchUpInside)
//        addJourneyView.createButton.addTarget(self,
//                                              action: #selector(create),
//                                              for: .touchUpInside)
    }
    
    @objc func cancel() {
        imagePreview.saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }

//    @objc func create() {
//        imagePreview.saveButton.isEnabled = true
//        dismiss(animated: true, completion: nil)
//    }
}

extension AddJourneyViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let changedText = currentText.replacingCharacters(in: stringRange, with: text)
        return changedText.count <= 250 // Pass your character count here
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        addJourneyView.newJourneyDescriptionTextView.text = ""
        addJourneyView.newJourneyDescriptionTextView.textColor = .black
    }
}

extension AddJourneyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addJourneyView.newJourneyNameTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 30
        let currentString: NSString = textField.text! as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
}
