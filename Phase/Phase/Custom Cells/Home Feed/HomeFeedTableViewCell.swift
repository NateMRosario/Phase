//
//  HomeFeedCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

protocol PresentVCDelgate: class {
    func mentionsTapped()
    func hashTagTapped()
}

class HomeFeedCollectionViewCell: UITableViewCell {
    
    weak var delegate: PresentVCDelgate?
    
    @IBOutlet weak var journeyTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var journeyLabel: ActiveLabel!
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
    
    public func set(image: UIImage, event: Event) {
        contentImage.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        journeyLabel.customize { (label) in
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            
            label.handleHashtagTap {_ in self.delegate?.hashTagTapped()}
            label.handleMentionTap({ (mention) in
                self.delegate?.mentionsTapped()
            })
        }
    }
}
