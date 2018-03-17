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
//            contentImageView.layer.cornerRadius = 8
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
    @IBOutlet weak var content3: UIImageView!
    
    @IBOutlet weak var extraWhiteSpace: UIView! {
        didSet {
            extraWhiteSpace.layer.shadowOpacity = 0.5
            extraWhiteSpace.layer.shadowOffset = CGSize(width: 0, height: -3)
            extraWhiteSpace.layer.shadowRadius = 20
        }
    }
    @IBOutlet weak var bottomWhiteSpace: UIView! {
        didSet {
            bottomWhiteSpace.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var contentTwo: UIImageView!
    
    public func set(image: UIImage) {
        let num = arc4random_uniform(3)
        
        // if image view is not nil stackView. content distribution = fill proportional else fill by equal distribution

        if num == 1 {
            contentImageView.image = image
            profileImage.image = image
            contentTwo.image = image
            content3.image = image
        }
        else if num == 2 {
            contentImageView.image = image
            profileImage.image = image
            content3.image = image
            contentTwo.image = nil
        } else {
            contentImageView.image = image
            profileImage.image = image
            content3.image = nil
            contentTwo.image = nil
        }
    }
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.layer.cornerRadius = 8
            stackView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 8
    }
}

extension DiscoverCollectionViewCell: GridViewProtocol {
    // TODO: MAKE THE SNAPSHOT VIEW == DiscoverCollectionViewNib
    func snapShotForTransition() -> UIView {
        let snapShotView = UIImageView(image: contentImageView.image)
        snapShotView.frame = contentImageView.frame
        snapShotView.layer.masksToBounds = contentImageView.layer.masksToBounds
        snapShotView.layer.cornerRadius = contentImageView.layer.cornerRadius
        snapShotView.contentMode = .scaleAspectFill
        return snapShotView
    }
}
