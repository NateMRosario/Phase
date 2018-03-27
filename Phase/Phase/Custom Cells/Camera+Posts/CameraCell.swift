//
//  CameraCell.swift
//  Phase
//
//  Created by C4Q on 3/20/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class CameraCell: UICollectionViewCell {

    lazy var imageView: UIImageView = {
        let cellImage = UIImageView()
        cellImage.contentMode = .scaleAspectFill
        cellImage.image = #imageLiteral(resourceName: "placeholder-image")
        cellImage.backgroundColor = .white
        cellImage.layer.masksToBounds = true
        return cellImage
    }()

    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        backgroundColor = UIColor.white
        setupViews()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
    }

    private func setupViews() {
        setupImageView()
    }

    // All Constraints Go Here.

    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1),
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 1),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
}
