//
//  FollowsTableViewCell.swift
//  Phase
//
//  Created by C4Q on 3/21/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class FollowsTableViewCell: UITableViewCell {
    
    lazy var userImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
//        image.layer.cornerRadius = 4
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .blue
        setupViews()
    }
    private func setupViews() {
        addSubview(userImage)
        
        userImage.snp.makeConstraints { (image) in
            image.edges.equalTo(self)
//            image.top.leading.equalTo(self).offset(8)
//            image.bottom.equalTo(self).offset(-8)
        }
    }

}
