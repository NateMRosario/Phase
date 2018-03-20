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
        bc.image = #imageLiteral(resourceName: "Electric Violet")
        return bc
    }()
    
    lazy var buttonContainer: UIView = {
        let bc = UIView()
        bc.backgroundColor = .black
        bc.layer.opacity = 0.6
        return bc
    }()
    
    lazy var shutterButton: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "shutterButton"), for: .normal)
        button.backgroundColor = .clear
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        return button
    }()
    
    lazy var switchCamera: UIButton = {
        let button = UIButton()
        button.setImage(#imageLiteral(resourceName: "switchCameraButton"), for: .normal) //get image assets and change image
        button.backgroundColor = .clear
        button.layer.cornerRadius = 2
        button.layer.masksToBounds = true
        return button
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
        setupButtonContainer()
        setupShutterButton()
        setupSwitchCameraButton()
        
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
    
    private func setupButtonContainer() {
        addSubview(buttonContainer)
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonContainer.topAnchor.constraint(equalTo: buttonContainerBackground.topAnchor),
            buttonContainer.widthAnchor.constraint(equalTo: buttonContainerBackground.safeAreaLayoutGuide.widthAnchor, multiplier: 1),
            buttonContainer.bottomAnchor.constraint(equalTo: buttonContainerBackground.safeAreaLayoutGuide.bottomAnchor)
            ])
    }
    
    private func setupShutterButton() {
        addSubview(shutterButton)
        shutterButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            shutterButton.topAnchor.constraint(equalTo: buttonContainer.safeAreaLayoutGuide.topAnchor, constant: 10),
//            shutterButton.bottomAnchor.constraint(equalTo: buttonContainer.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            shutterButton.heightAnchor.constraint(equalTo: buttonContainer.heightAnchor, multiplier: 0.3),
            shutterButton.widthAnchor.constraint(equalTo: shutterButton.heightAnchor, multiplier: 1),
            shutterButton.centerXAnchor.constraint(equalTo: buttonContainer.safeAreaLayoutGuide.centerXAnchor)

            ])
    }
    
    private func setupSwitchCameraButton() {
        addSubview(switchCamera)
        switchCamera.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            switchCamera.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            switchCamera.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -10),
            switchCamera.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.08),
            switchCamera.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.08)
            ])
    }

    
}

