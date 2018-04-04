//
//  MozaikCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Kingfisher

class MozaikCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mozaik: UIImageView!
    @IBOutlet weak var howManyMoreLabel: UILabel!
    @IBOutlet weak var isVideo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(with event: Event) {
        howManyMoreLabel.text = ""
        mozaik.kf.setImage(with: URL(string: "https://s3.amazonaws.com/phase-journey-events/\(event._media!)"))
    }
}
