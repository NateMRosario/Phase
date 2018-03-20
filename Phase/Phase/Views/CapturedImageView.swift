//
//  CapturedImageView.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class CapturedImageView: UIView {
    
    lazy var cancelButton: UIButton = {
        let cancel = UIButton()
        cancel.setTitle("Cancel", for: .normal)
        cancel.setTitleColor(.red, for: .normal)
        cancel.backgroundColor = .white
        cancel.layer.opacity = 0.7
        cancel.layer.borderColor = UIColor.black.cgColor
        cancel.layer.borderWidth = 1
        cancel.layer.cornerRadius = 17
        cancel.layer.masksToBounds = true
        return cancel
    }()
    
    lazy var useButton: UIButton = {
        let use = UIButton()
        use.setTitle("Post", for: .normal)
        use.setTitleColor(.blue, for: .normal)
        use.backgroundColor = .white
        use.layer.opacity = 0.7
        use.layer.borderColor = UIColor.black.cgColor
        use.layer.borderWidth = 1
        use.layer.cornerRadius = 17
        use.layer.masksToBounds = true
        return use
    }()
    
    lazy var saveButton: UIButton = {
        let save = UIButton()
        save.setImage(#imageLiteral(resourceName: "download"), for: .normal)
        save.backgroundColor = .white
        save.layer.opacity = 0.7
        save.layer.borderColor = UIColor.black.cgColor
        save.layer.borderWidth = 1
        save.layer.cornerRadius = 20
        save.layer.masksToBounds = true
        return save
    }()
    
    lazy var imagePreviewView: UIImageView = {
        let preview = UIImageView()
        preview.contentMode = .scaleAspectFill
        preview.layer.masksToBounds = true
        return preview
    }()
    
    lazy var headerView: UIView = {
        let header = UIView()
        //header.layer.opacity = 0.5
        header.backgroundColor = .black
        return header
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
        backgroundColor = .black
        setupViews()
    }
    
    private func setupViews() {
        setupHeaderView()
        setupImagePreviewView()
        setupCancelButton()
        setupUseButton()
        setupSaveButton()
    }
    
    private func setupHeaderView(){
        addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.15),
            headerView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupImagePreviewView(){
        addSubview(imagePreviewView)
        imagePreviewView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            //imagePreviewView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            imagePreviewView.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            imagePreviewView.heightAnchor.constraint(equalTo: imagePreviewView.widthAnchor),
            imagePreviewView.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            imagePreviewView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor)
            ])
    }
    
    private func setupCancelButton(){
        addSubview(cancelButton)
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cancelButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            cancelButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            cancelButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15)
            ])
    }
    
    private func setupUseButton(){
        addSubview(useButton)
        useButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            useButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
            useButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            useButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor, multiplier: 1)
            ])
    }
    
    private func setupSaveButton(){
        addSubview(saveButton)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            saveButton.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 10),
            saveButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            saveButton.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 0.1),
            saveButton.heightAnchor.constraint(equalTo: saveButton.widthAnchor, multiplier: 1)
            ])
        
    }
    
}
