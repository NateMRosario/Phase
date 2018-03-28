//
//  CameraView.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import AVFoundation

class CameraView: UIView {
    
    lazy var previewLayerContainer: UIView = {
        let pl = UIView()
        return pl
    }()
    
    lazy var buttonContainerBackground: UIImageView = {
        let bc = UIImageView()
        bc.image = #imageLiteral(resourceName: "October Silence")
        return bc
    }()
    
    lazy var containerView: UIView = {
        let bc = UIView()
        bc.backgroundColor = .white
        bc.layer.opacity = 0.45
        return bc
    }()
    
    lazy var buttonContainer: UIView = {
        let bc = UIView()
        bc.backgroundColor = .clear
        return bc
    }()
    
    lazy var chooseImageButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "selectImage"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var shutterButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "shutterButton"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var switchCameraButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "switchCameraButton"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        return button
    }()
    
    let cameraCellID = "CameraCell"
    
    // MARK: - Lazy variables
    lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(CameraCell.self, forCellWithReuseIdentifier: cameraCellID)
        return collectionView
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
        setupPreviewLayerContainer()
        setupButtonContainerBackground()
        setupContainerView()
        setupButtonContainer()
        setupChooseImageButton()
        setupShutterButton()
        setupSwitchCameraButton()
        setupPhotoCollectionView()
    }
    
    private func setupPreviewLayerContainer(){
        addSubview(previewLayerContainer)
        previewLayerContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            previewLayerContainer.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            previewLayerContainer.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            previewLayerContainer.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1)
            ])
    }
    
    private func setupButtonContainerBackground() {
        addSubview(buttonContainerBackground)
        buttonContainerBackground.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonContainerBackground.topAnchor.constraint(equalTo: previewLayerContainer.bottomAnchor),
            buttonContainerBackground.widthAnchor.constraint(equalTo: safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            buttonContainerBackground.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func setupContainerView() {
        addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: buttonContainerBackground.safeAreaLayoutGuide.topAnchor),
            containerView.widthAnchor.constraint(equalTo: buttonContainerBackground.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            containerView.bottomAnchor.constraint(equalTo: buttonContainerBackground.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func setupButtonContainer() {
        addSubview(buttonContainer)
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonContainer.topAnchor.constraint(equalTo: containerView.topAnchor),
            buttonContainer.widthAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            buttonContainer.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.33),
            buttonContainer.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
    
    private func setupChooseImageButton() {
        addSubview(chooseImageButton)
        chooseImageButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            chooseImageButton.leadingAnchor.constraint(equalTo: buttonContainer.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            chooseImageButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 0.6),
            chooseImageButton.widthAnchor.constraint(equalTo: chooseImageButton.heightAnchor, multiplier: 1),
            chooseImageButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor)
            ])
    }
    
    private func setupShutterButton() {
        addSubview(shutterButton)
        shutterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shutterButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 1),
            shutterButton.widthAnchor.constraint(equalTo: shutterButton.heightAnchor, multiplier: 1),
            shutterButton.centerXAnchor.constraint(equalTo: buttonContainer.safeAreaLayoutGuide.centerXAnchor),
            shutterButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor)
            ])
    }
    
    private func setupSwitchCameraButton() {
        addSubview(switchCameraButton)
        switchCameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchCameraButton.trailingAnchor.constraint(equalTo: buttonContainer.safeAreaLayoutGuide.trailingAnchor, constant: -30),
            switchCameraButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 0.8),
            switchCameraButton.widthAnchor.constraint(equalTo: switchCameraButton.heightAnchor, multiplier: 1),
            switchCameraButton.centerYAnchor.constraint(equalTo: buttonContainer.centerYAnchor)
            ])
    }

    private func setupPhotoCollectionView() {
        addSubview(photoCollectionView)
        photoCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            photoCollectionView.topAnchor.constraint(equalTo: buttonContainer.bottomAnchor, constant: 8),
            photoCollectionView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1),
            photoCollectionView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -2),
            photoCollectionView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
            ])
    }
}

