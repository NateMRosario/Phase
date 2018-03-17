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
        // if image view is not nil stackView. content distribution = fill proportional else fill by equal distribution
        contentImageView.image = image
        profileImage.image = image
        contentTwo.image = #imageLiteral(resourceName: "f")
    }
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.layer.cornerRadius = 8
            stackView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
