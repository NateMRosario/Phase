//
//  CameraPreviewViewController.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class PreviewViewController: UIViewController {
    
    public let imagePreview = CapturedImageView()
    
    public var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imagePreview)
        imagePreview.cancelButton.addTarget(self,
                                            action: #selector(cancel),
                                            for: .touchUpInside
        )
//        imagePreview.useButton.addTarget(self,
//                                         action: #selector(use),
//                                         for: .touchUpInside
//        )
        imagePreview.saveButton.addTarget(self,
                                          action: #selector(save),
                                          for: .touchUpInside)
        
        imagePreview.imagePreviewView.image = image
    }
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.image = image
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
//    @objc func use(){
//        let cpVC = NewPostViewController(image: image)
//        present(cpVC, animated: true, completion: nil)
//    }
    
    @objc func save(sender: UIButton){
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        UIButton.animate(withDuration: 0.2, animations: {
            sender.alpha = 0.0
        }, completion:{(finished) in
            self.imagePreview.saveButton.setImage(UIImage(named: "saved"), for: .normal)
            self.imagePreview.saveButton.backgroundColor = UIColor(white: 1, alpha: 0.7)
            self.imagePreview.saveButton.layer.borderColor = UIColor.black.cgColor
            self.imagePreview.saveButton.layer.borderWidth = 1
            self.imagePreview.saveButton.layer.cornerRadius = 20
            self.imagePreview.saveButton.layer.masksToBounds = true
            UIView.animate(withDuration: 0.2,animations:{
                sender.alpha = 1.0
            },completion:nil)
        })
    }
    
}

