//
//  postViewCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/23/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class JourneyCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    lazy var journeyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "placeholder-image")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var journeyNameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 8, weight: .regular)
        label.textAlignment = .center
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    lazy var selectedJourneyLayer: UIImageView = {
        let sl = UIImageView()
        sl.layer.opacity = 0.5
        sl.image = #imageLiteral(resourceName: "checked")
        sl.contentMode = .scaleAspectFit
        sl.isHidden = true
        return sl
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
        setupJourneyImageView()
        setupJourneyNameLabel()
        setupJourneySelectedLayer()
    }
 
    // Contraints
    private func setupJourneyImageView() {
        addSubview(journeyImageView)
        journeyImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            journeyImageView.topAnchor.constraint(equalTo: topAnchor),
            journeyImageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1),
            journeyImageView.heightAnchor.constraint(equalTo: journeyImageView.widthAnchor, multiplier: 1),
            journeyImageView.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupJourneyNameLabel() {
        addSubview(journeyNameLabel)
        journeyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            journeyNameLabel.topAnchor.constraint(equalTo: journeyImageView.bottomAnchor, constant: 4),
            journeyNameLabel.widthAnchor.constraint(equalTo: journeyImageView.widthAnchor, multiplier: 1),
            journeyNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            ])
    }
    
    private func setupJourneySelectedLayer() {
        addSubview(selectedJourneyLayer)
        selectedJourneyLayer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedJourneyLayer.topAnchor.constraint(equalTo: journeyImageView.topAnchor),
            selectedJourneyLayer.widthAnchor.constraint(equalTo: journeyImageView.widthAnchor, multiplier: 1),
            selectedJourneyLayer.heightAnchor.constraint(equalTo: journeyImageView.widthAnchor, multiplier: 1),
            selectedJourneyLayer.centerXAnchor.constraint(equalTo: journeyImageView.centerXAnchor)
            ])
    }
    
}
