//
//  AddJourneyViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

protocol AddNewJourneyViewDelegate: class {
    func createdNewJourney(with name: String, details: String)
}

class AddJourneyViewController: UIViewController {
    
    let addJourneyView = CreateNewJourneyView()
    let imagePreview = CapturedImageView()
    weak var delegate: AddNewJourneyViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addJourneyView)
        addJourneyView.newJourneyDescriptionTextView.delegate = self
        addJourneyView.cancelButton.addTarget(self,
                                              action: #selector(cancel),
                                              for: .touchUpInside)
        addJourneyView.createButton.addTarget(self,
                                              action: #selector(create),
                                              for: .touchUpInside)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let _ = touches.first {
            DispatchQueue.main.async {
                self.view.endEditing(true)
            }
        }
    }
    
    @objc private func cancel() {
        imagePreview.saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func create() {
        guard addJourneyView.newJourneyDescriptionTextView.text != "" else {
            DispatchQueue.main.async {
                self.showAlert(title: "Error", message: "Journey name cannot be empty")
            }; return}
        
        let set = checkHashTags(from: addJourneyView.newJourneyDescriptionTextView.text)
        DynamoDBManager.shared.createJourney(title: addJourneyView.newJourneyNameTextField.text!,
                                             description: addJourneyView.newJourneyDescriptionTextView.text!,
                                             hashtags: set, completion: {(error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")}
            } else {
                DispatchQueue.main.async {
                    self.dismiss(animated: true) {
                        self.imagePreview.saveButton.isEnabled = true
                        self.delegate?.createdNewJourney(with: self.addJourneyView.newJourneyNameTextField.text!,
                                                         details: self.addJourneyView.newJourneyDescriptionTextView.text!)
                    }
                }
            }
        })
//        dismiss(animated: true) {
//            self.delegate?.createdNewJourney(with: , details: <#T##String#>)
//        }
    }
    
    func checkHashTags(from string: String) -> Set<String>? {
        var set = Set<String>()
        let spaceSeparatedStr = string.components(separatedBy: " ")
        for word in spaceSeparatedStr {
            if word.hasPrefix("#") {
                set.insert(word)
            }
        }
        if set.isEmpty {return nil}
        return set
    }
}

extension AddJourneyViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.textColor = .black
    }
}
