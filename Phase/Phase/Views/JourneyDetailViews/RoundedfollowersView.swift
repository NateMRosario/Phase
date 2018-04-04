//
//  RoundedfollowersView.swift
//  Phase
//
//  Created by Clint Mejia on 4/3/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class RoundedfollowersView: UIView {
    
    lazy var imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "7-R5CLfl_400x400")
        iv.contentMode = .scaleAspectFit
        iv.layer.borderWidth = 0.5
        iv.layer.borderColor = UIColor.gray.cgColor
        iv.tag = 0
        iv.isUserInteractionEnabled = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(tag: Int) {
        self.init(frame: UIScreen.main.bounds)
        imageView.tag = tag
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        setupImageView()
    }
    
    private func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }

}
