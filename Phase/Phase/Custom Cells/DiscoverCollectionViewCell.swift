//
//  DiscoverCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var profileImage: UIImageView! {
        didSet {
            profileImage.layer.cornerRadius = profileImage.bounds.height / 2
            profileImage.borderColor = UIColor.white
            profileImage.layer.borderWidth = 2
        }
    }
    @IBOutlet weak var extraWhiteSpace: UIView! {
        didSet {
            extraWhiteSpace.layer.shadowOpacity = 0.5
            extraWhiteSpace.layer.shadowOffset = CGSize(width: 0, height: -3)
            extraWhiteSpace.layer.shadowRadius = 20
        }
    }
    @IBOutlet weak var bottomWhiteSpace: UIView! {
        didSet {
            bottomWhiteSpace.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var stackViewContainer: UIView! {
        didSet {
            stackViewContainer.layer.cornerRadius = 10
            stackViewContainer.clipsToBounds = true
        }
    }
    
    lazy var stackImageView: UIImageView = {
        let siv = UIImageView()
        siv.contentMode = .scaleAspectFill
        siv.clipsToBounds = true
        return siv
    }()
    
    lazy var stackImageView2: UIImageView = {
        let siv = UIImageView()
        siv.contentMode = .scaleAspectFill
        siv.clipsToBounds = true
        return siv
    }()
    
    lazy var stackImageView3: UIImageView = {
        let siv = UIImageView()
        siv.contentMode = .scaleAspectFill
        siv.clipsToBounds = true
        return siv
    }()
    
    public func set(image: UIImage) {
        let num = arc4random_uniform(5)
        
        // if image view is not nil stackView. content distribution = fill proportional else fill by equal distribution

        if num == 1 {
            profileImage.image = image
            stackView.insertArrangedSubview(stackImageView, at: 0)
            stackView.insertArrangedSubview(stackImageView2, at: 1)
            stackView.insertArrangedSubview(stackImageView3, at: 2)
            stackImageView.image = image
            stackImageView2.image = image
            stackImageView3.image = image
        }
        else if num == 2 || num == 4 {
            stackView.insertArrangedSubview(stackImageView, at: 0)
            stackView.insertArrangedSubview(stackImageView2, at: 1)
            profileImage.image = image
            stackImageView.image = image
            stackImageView2.image = image
        } else {
            stackView.insertArrangedSubview(stackImageView, at: 0)
            stackImageView.image = image
            profileImage.image = image
        }
    }
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension DiscoverCollectionViewCell: GridViewProtocol {
    // TODO: MAKE THE SNAPSHOT VIEW == DiscoverCollectionViewNib
    func snapShotForTransition() -> UIView {
        let snapShotView = UIImageView(image: stackImageView.image)
        snapShotView.frame = CGRect.init(x: 0, y: 0, width: stackImageView.frame.width, height: stackImageView.frame.height * CGFloat(3))
//        snapShotView.layer.masksToBounds = contentImageView.layer.masksToBounds
        snapShotView.layer.cornerRadius = stackImageView.layer.cornerRadius
        snapShotView.contentMode = .scaleAspectFill
        return snapShotView
    }
}
