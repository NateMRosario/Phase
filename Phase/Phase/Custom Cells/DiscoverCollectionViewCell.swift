//
//  DiscoverCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet dynamic fileprivate(set) weak var contentImageView: UIImageView! {
        didSet {
            contentImageView.layer.cornerRadius = 8
            contentImageView.layer.masksToBounds = true
        }
    }
    
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.bounds.height / 2
            profileImage.borderColor = UIColor.white
            profileImage.layer.borderWidth = 2
        }
    }
    
    public func set(image: UIImage) {
        contentImageView.image = image
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension DiscoverCollectionViewCell: GridViewProtocol {
    func snapShotForTransition() -> UIView {
        let snapShotView = UIImageView(image: contentImageView.image)
        snapShotView.frame = contentImageView.frame
        snapShotView.layer.masksToBounds = contentImageView.layer.masksToBounds
        snapShotView.layer.cornerRadius = contentImageView.layer.cornerRadius
        return snapShotView
    }
}
