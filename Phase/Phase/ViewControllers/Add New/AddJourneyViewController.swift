//
//  AddJourneyViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class AddJourneyViewController: UIViewController {
    
    let addJourneyView = CreateNewJourneyView()
    let imagePreview = CapturedImageView()

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
    
    @objc func cancel() {
        imagePreview.saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }

    @objc func create() {
        var set = Set<String>()
        set.insert("#yoo")
        DynamoDBManager.shared.createJourney(title: addJourneyView.newJourneyNameTextField.text ?? "", description: addJourneyView.newJourneyDescriptionTextView.text ?? "", hashtags: set)
        imagePreview.saveButton.isEnabled = true
        dismiss(animated: true, completion: nil)
    }
}
