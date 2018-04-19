//
//  HomeEmptyView.swift
//  Phase
//
//  Created by C4Q on 4/5/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

class HomeEmptyView: UIView {
    
    ///Empty state view
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Follow A Journey Through the Discovery Tab"
        label.font = UIFont(name: "Damascus", size: 30)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var pointArrow: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "DownArrow")
        return image
    }()
    
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
    /// 3/10th from leading
    private func setupViews() {
        addSubview(titleLabel)
        addSubview(pointArrow)
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
            make.height.equalTo(40)
        }
        
        pointArrow.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.leading.equalTo(self).offset(UIScreen.main.bounds.width * 0.25)
        }
        
    }
}
