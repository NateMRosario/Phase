//
//  CreateNewJourneyView.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Material

class CreateNewJourneyView: UIView {
    
    lazy var headerBackground: UIImageView = {
        let header = UIImageView()
        header.image = #imageLiteral(resourceName: "October Silence")
        header.contentMode = .scaleAspectFill
        header.clipsToBounds = true
        return header
    }()
    
    lazy var headerView: UIView = {
        let header = UIView()
        header.layer.opacity = 0.45
        header.backgroundColor = .white
        return header
    }()
    
    lazy var cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        cancel.layer.opacity = 0.7
        cancel.layer.cornerRadius = 20
        cancel.layer.masksToBounds = true
        return cancel
    }()
    
    lazy var createButton: UIButton = {
        let create = UIButton()
        create.setTitle("Create", for: .normal)
        create.setTitleColor(.blue, for: .normal)
        create.backgroundColor = .clear
        create.layer.borderColor = UIColor.black.cgColor
        create.layer.borderWidth = 1
        create.layer.cornerRadius = 17
        create.layer.masksToBounds = true
        return create
    }()
    
    lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.text = "New Journey"
        label.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    lazy var containerView: UIView = {
        let header = UIView()
        header.layer.opacity = 0.45
        header.backgroundColor = .white
        return header
    }()
    
    lazy var textEntryView: UIView = {
        let header = UIView()
        header.layer.opacity = 0.45
        header.backgroundColor = .white
        return header
    }()
    
    lazy var newJourneyNameTextField: TextField = {
        let nj = TextField()
        nj.placeholder = "Journey Name"
        nj.textAlignment = .left
        return nj
    }()
    
    
    lazy var newJourneyDescriptionTextView: TextView = {
        let tv = TextView()
        tv.font = UIFont.systemFont(ofSize: 17)
        tv.textAlignment = .left
        tv.placeholder = "Enter journey description."
        tv.layer.borderWidth = 1
        tv.textColor = .lightGray
        tv.layer.borderColor = UIColor.lightGray.cgColor
        tv.layer.cornerRadius = 6
        tv.layer.masksToBounds = true
        return tv
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    
    private func setupViews() {
        setupHeaderBackground()
        setupHeaderView()
        setupCancelButton()
        setupCreateButton()
        setupHeaderLabel()
        setupContainerView()
        setupTextEntryContainer()
        setupNewJourneyNameTextField()
        setupNewJourneyDescriptionTextView()
    }
    
    private func setupHeaderBackground() {
        addSubview(headerBackground)
        headerBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerBackground.topAnchor.constraint(equalTo: topAnchor),
            headerBackground.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            headerBackground.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            headerBackground.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.10),
            headerBackground.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
            ])
    }
    
    private func setupHeaderView() {
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: headerBackground.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: headerBackground.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: headerBackground.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: headerBackground.bottomAnchor),
            headerView.centerXAnchor.constraint(equalTo: headerBackground.centerXAnchor)
            ])
    }
    
    private func setupCancelButton() {
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            cancelButton.centerYAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.centerYAnchor),
            cancelButton.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier: 0.6),
            cancelButton.widthAnchor.constraint(equalTo: cancelButton.heightAnchor, multiplier: 1)
            ])
    }
    
    private func setupCreateButton() {
        addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createButton.trailingAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            createButton.centerYAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.centerYAnchor),
            createButton.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.15)
            ])
    }
    
    private func setupHeaderLabel() {
        addSubview(headerLabel)
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerLabel.centerXAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.centerXAnchor),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            containerView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            containerView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            containerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func setupTextEntryContainer() {
        addSubview(textEntryView)
        textEntryView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textEntryView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.8),
            textEntryView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.8),
            textEntryView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            textEntryView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
            ])
    }
    
    private func setupNewJourneyNameTextField() {
        addSubview(newJourneyNameTextField)
        newJourneyNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newJourneyNameTextField.topAnchor.constraint(equalTo: textEntryView.topAnchor),
            newJourneyNameTextField.widthAnchor.constraint(equalTo: textEntryView.widthAnchor, multiplier: 1),
            newJourneyNameTextField.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.035),
            newJourneyNameTextField.centerXAnchor.constraint(equalTo: textEntryView.centerXAnchor)
            ])
    }
    
    private func setupNewJourneyDescriptionTextView() {
        addSubview(newJourneyDescriptionTextView)
        newJourneyDescriptionTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newJourneyDescriptionTextView.topAnchor.constraint(equalTo: newJourneyNameTextField.bottomAnchor, constant: 40),
            newJourneyDescriptionTextView.widthAnchor.constraint(equalTo: textEntryView.widthAnchor, multiplier: 1),
            newJourneyDescriptionTextView.heightAnchor.constraint(equalTo: newJourneyDescriptionTextView.widthAnchor, multiplier: 0.4),
            newJourneyDescriptionTextView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
}

