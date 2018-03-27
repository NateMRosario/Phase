//
//  HomeFeedCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class HomeFeedCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var journeyLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel! {
        didSet {
            likeLabel.layer.cornerRadius = likeLabel.bounds.height / 2
            likeLabel.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var postLabel: UILabel!
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var userImage: UIImageView! {
        didSet {
            userImage.layer.cornerRadius = userImage.bounds.height / 2
            userImage.borderColor = UIColor.white
            userImage.layer.borderWidth = 2
        }
    }
    
    @IBOutlet dynamic fileprivate(set) weak var contentImage: UIImageView! {
        didSet {
            contentImage.layer.masksToBounds = true
        }
    }
    
    public func set(image: UIImage) {
        contentImage.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
}
