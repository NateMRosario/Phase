//
//  DiscoverCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Kingfisher

class DiscoverCollectionViewCell: UICollectionViewCell {
    
    var journey: Journey? {
        didSet {
            guard let journey = self.journey else { return }
            DispatchQueue.main.async {
                self.journeyNameLabel.text = journey._title
            }
            DynamoDBManager.shared.loadUser(userId: journey._userId!) { (user, error) in
                if let error = error {
                    print(error)
                } else if let user = user {
                    self.user = user
                }
            }
        }
    }
    var event: Event? {
        didSet {
            guard let event = event else { return }
            DispatchQueue.main.async {
                self.likesLabel.text = String((event._numberOfLikes as! Int))
                self.descriptionLabel.text = event._caption
            }
        }
    }
    var user: AppUser? {
        didSet {
            DispatchQueue.main.async {
                guard let user = self.user else { return }
                self.usernameLabel.text = user._username!
                guard let imageLink = user._profileImage else { return self.profileImage.image = #imageLiteral(resourceName: "profile-unselected") }
                let imageUrl = URL(string: "https://s3.amazonaws.com/phase-journey-events/\(imageLink)")
                
                self.profileImage.kf.indicatorType = .activity
                self.profileImage.kf.setImage(with: imageUrl, placeholder: #imageLiteral(resourceName: "profile-unselected"), options: nil, progressBlock: nil, completionHandler: nil)
            }
        }
    }
    
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
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likesLabel: UILabel!
    
    @IBOutlet weak var journeyNameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
//        guard let event = event else { return }
//        DynamoDBManager.shared.likeEvent(event: event) { (error) in
//            if let error = error {
//                print(error)
//            } else {
//                print("successfully liked")
//            }
//        }
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
    
    public func set() {
//        let num = 10
        
        guard let journey = journey else { return }
        guard let event = journey._lastEvent else { return }
        DynamoDBManager.shared.loadEvent(eventId: journey._lastEvent!) { (event, error) in
            if let error = error {
                
            } else if let event = event {
                self.event = event
                guard let currentImage = event._media else {return}
                let url = URL(string: "https://s3.amazonaws.com/phase-journey-events/\(currentImage)")
                DispatchQueue.main.async {
                    self.image3.image = nil
                    self.image2.image = nil
                    self.image1.kf.indicatorType = .activity
                    self.image1.kf.setImage(with: url, placeholder: #imageLiteral(resourceName: "placeholder-image"), options: nil, progressBlock: nil, completionHandler: nil)
                    //self.profileImage.image = image
                }
            }
        }
        
        
        // if image view is not nil stackView. content distribution = fill proportional else fill by equal distribution

//        if num == 1 {
//            profileImage.image = image
//            image1.image = image
//            image2.image = image
//            image3.image = image
//        }
//        else if num == 2 || num == 4 || num == 6 {
//            image3.image = nil
//            image1.image = image
//            image2.image = image
//            profileImage.image = image
//        } else {
//            image3.image = nil
//            image2.image = nil
//            image1.image = image
//            profileImage.image = image
//        }
    }
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

//extension DiscoverCollectionViewCell: GridViewProtocol {
//    // TODO: MAKE THE SNAPSHOT VIEW == DiscoverCollectionViewNib
//    func snapShotForTransition() -> UIView {
//        let snapShotView = UIImageView(image: stackImageView.image)
//        snapShotView.frame = CGRect.init(x: 0, y: 0, width: stackImageView.frame.width, height: stackImageView.frame.height * CGFloat(3))
////        snapShotView.layer.masksToBounds = contentImageView.layer.masksToBounds
//        snapShotView.layer.cornerRadius = stackImageView.layer.cornerRadius
//        snapShotView.contentMode = .scaleAspectFill
//        return snapShotView
//    }
//}

