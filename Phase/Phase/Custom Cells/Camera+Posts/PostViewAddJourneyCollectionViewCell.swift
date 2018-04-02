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
    
    lazy var newJourneyLabel: UILabel = {
        let label = UILabel()
        label.text = "Add Journey"
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.backgroundColor = .white
        return label
    }()
    
    lazy var cellLayer: UIView = {
        let layer = UIView()
        layer.backgroundColor = .clear
        return layer
    }()
  
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: UIScreen.main.bounds)
//        self.layer.masksToBounds = true
//        self.layer.cornerRadius = 10
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
        setupNewJourneyLabel()
        setupCellLayer()
    }
    
    // Contraints
    private func setupAddJourneyImageView() {
        addSubview(addJourneyImageView)
        addJourneyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addJourneyImageView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            addJourneyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            addJourneyImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            addJourneyImageView.heightAnchor.constraint(equalTo: addJourneyImageView.widthAnchor)
            ])
    }
    
    private func setupNewJourneyLabel() {
        addSubview(newJourneyLabel)
        newJourneyLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newJourneyLabel.topAnchor.constraint(equalTo: addJourneyImageView.bottomAnchor, constant: 12),
            newJourneyLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            newJourneyLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupCellLayer() {
        addSubview(cellLayer)
        cellLayer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cellLayer.topAnchor.constraint(equalTo: topAnchor),
            cellLayer.leadingAnchor.constraint(equalTo: leadingAnchor),
            cellLayer.trailingAnchor.constraint(equalTo: trailingAnchor),
            cellLayer.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}
