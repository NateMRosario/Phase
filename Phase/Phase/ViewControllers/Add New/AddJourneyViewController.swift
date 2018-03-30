//
//  AddJourneyViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

protocol AddNewJourneyViewDelegate: class {
    func createdNewJourney()
}

class AddJourneyViewController: UIViewController {
    
    let addJourneyView = CreateNewJourneyView()
    let imagePreview = CapturedImageView()
    weak var delegate: AddNewJourneyViewDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(addJourneyView)
        addJourneyView.cancelButton.addTarget(self,
                                              action: #selector(cancel),
                                              for: .touchUpInside)
        addJourneyView.createButton.addTarget(self,
                                              action: #selector(create),
                                              for: .touchUpInside)
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
        DynamoDBManager.shared.createJourney(title: addJourneyView.newJourneyDescriptionTextView.text,
                                             description: addJourneyView.newJourneyDescriptionTextView.text ?? "sdfklsdjfklds",
                                             hashtags: set, completion: {(error) in
            if let error = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Created", message: "Created New Journey")
                }
            }
        })
        imagePreview.saveButton.isEnabled = true
        dismiss(animated: true)
    }
    
    func checkHashTags(from string: String) -> Set<String> {
        var set = Set<String>()
        let spaceSeparatedStr = string.components(separatedBy: " ")
        for word in spaceSeparatedStr {
            if word.hasPrefix("#") {
                set.insert(word)
            }
        }
        return set
    }
}
