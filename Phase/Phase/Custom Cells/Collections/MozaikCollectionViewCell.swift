//
//  MozaikCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class MozaikCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var mozaik: UIImageView!
    @IBOutlet weak var howManyMoreLabel: UILabel!
    @IBOutlet weak var isVideo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
