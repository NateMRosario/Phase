//
//  HomeFeedCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

protocol PresentVCDelgate: class {
    func mentionsTapped()
    func hashTagTapped()
    func updateTableView()
}

class HomeFeedTableViewCell: UITableViewCell {
    
    weak var delegate: PresentVCDelgate?
    
    var journey: Journey?
    
    var eventImage: UIImage?
    @IBOutlet weak var journeyTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    @IBOutlet weak var journeyLabel: ActiveLabel!
    
    @IBOutlet weak var detailView: UIView! {
        didSet {
            detailView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var userImage: UIImageView! {
        didSet {
            userImage.layer.cornerRadius = userImage.bounds.height / 2
            userImage.borderColor = UIColor.white
            userImage.layer.borderWidth = 2
        }
    }
    
    @IBOutlet dynamic fileprivate(set) weak var contentImage: UIImageView! {
        didSet {
            contentImage.layer.masksToBounds = true
        }
    }
    private func convertDate(from num: NSNumber?) -> String? {
        guard num != nil else {return nil}
        let date = Date(timeIntervalSinceReferenceDate: num as! TimeInterval)
        return date.timeAgoDisplay()
    }
    public func configureCell(event: Event) {
        
        var currentJourney = Journey()
        var currentUser = AppUser()
        DynamoDBManager.shared.loadJourney(journeyId: event._journey!) { (journey, error) in
            if let error = error {
                print(error)
            }
            currentJourney = journey
            self.journey = journey
        }
        DynamoDBManager.shared.loadUser(userId: event._userId!) { (user, error) in
            if let error = error {
                print(error)
            }
            currentUser = user
        }
        userName.text = currentUser?._username
        timeStamp.text = convertDate(from: event._creationDate)
        journeyLabel.text =  currentJourney?._title
        
        guard let currentImage = event._media else {return}
        let url = URL(string: "https://s3.amazonaws.com/phase-journey-events/\(currentImage)")
        
        contentImage.kf.setImage(with: url)
//        { (image, error, cache, url) in
//            if let image = image {
//                let ratio = image.size.width / image.size.height
//                if ratio > 1 {
//                    let newHeight = self.contentView.frame.width / ratio
//                    self.contentImage.bounds.size = CGSize(width: self.contentView.frame.width, height: newHeight)
//                        self.delegate?.updateTableView()
//                } else {
//                    let newWidth = self.contentView.frame.height * ratio
//                    self.contentImage.frame.size = CGSize(width: newWidth, height: self.contentView.frame.height)
//                    self.delegate?.updateTableView()
//                }
//            }
//        }
        guard let image = eventImage else {return userImage.image = #imageLiteral(resourceName: "7-R5CLfl_400x400") }
        userImage.image = image
    }
        
    public func set(image: UIImage, event: Event) {
        contentImage.image = image
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        journeyLabel.customize { (label) in
            label.hashtagColor = UIColor(red: 85.0/255, green: 172.0/255, blue: 238.0/255, alpha: 1)
            label.mentionColor = UIColor(red: 238.0/255, green: 85.0/255, blue: 96.0/255, alpha: 1)
            
            label.handleHashtagTap {_ in self.delegate?.hashTagTapped()}
            label.handleMentionTap({ (mention) in
                self.delegate?.mentionsTapped()
            })
        }
    }
}
