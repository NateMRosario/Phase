//
//  PostViewAddJourneyCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class AddJourneyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    lazy var addJourneyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "add")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        return imageView
    }()
  
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = 10
        commonInit()
        setupViews()
    }
    
    // required Storyboard
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        setupViews()
    }
    
    //MARK: - Functions
    private func commonInit() {
        backgroundColor = UIColor.white
    }
    
    // MARK: - Functions
    func setupViews() {
        setupAddJourneyImageView()
        //setupNewJourneyButton()
    }
    
    // Contraints
    private func setupAddJourneyImageView() {
        addSubview(addJourneyImageView)
        addJourneyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addJourneyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            addJourneyImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            addJourneyImageView.heightAnchor.constraint(equalTo: addJourneyImageView.widthAnchor),
            addJourneyImageView.centerYAnchor.constraint(equalTo: centerYAnchor)
            ])
    }
    
}
