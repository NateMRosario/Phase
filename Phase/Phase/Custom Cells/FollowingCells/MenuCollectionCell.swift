//
//  MenuBarCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/22/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class MenuCollectionCell: UICollectionViewCell {
    
    lazy var menuTitle: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Damascus", size: 14)
        return label
    }()
    
    override var isHighlighted: Bool {
        didSet {
            menuTitle.textColor = isHighlighted ? UIColor(hex: "21d4fd") : UIColor.black
        }
    }
    override var isSelected: Bool {
        didSet {
            menuTitle.textColor = isSelected ? UIColor(hex: "21d4fd") : UIColor.black
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        commonInit()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .white
        setupViews()
    }
    private func setupViews() {
        addSubview(menuTitle)
        
        menuTitle.snp.makeConstraints { (label) in
            label.edges.equalTo(self)
        }
    }
}
