//
//  JourneyTableViewCell.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import ADMozaicCollectionViewLayout

class JourneyTableViewCell: UITableViewCell {
    
    var journey: Journey? {
        didSet {
            if let journey = journey {
                getEvents(for: journey)
            }
        }
    }
    var events = [Event]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var containter: UIView! {
        didSet {
            self.containter.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var mozaikLayout: ADMozaikLayout! {
        didSet {
            mozaikLayout.delegate = self
        }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.register(MozaikCollectionViewCell.self, forCellWithReuseIdentifier: "ADMozaikLayoutCell")
            collectionView.register(UINib.init(nibName: "MozaikCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ADMozaikLayoutCell")
        }
    }
    
    @IBOutlet weak var journeyTitle: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var startDateLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
            profileImageView.layer.borderWidth = 2
            profileImageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var watchersLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func convertDate(from num: NSNumber?) -> String? {
        guard num != nil else {return nil}
        let date = Date(timeIntervalSinceReferenceDate: num as! TimeInterval)
        print(date)
        return date.timeAgoDisplay()
    }
    
    public func configureCell(with journey: Journey, creator: AppUser?) {
        self.startDateLabel.text = convertDate(from: journey._creationDate)
        self.userName.text = creator?._username
        self.watchersLabel.text = "Watchers: \(String(describing: journey._numberOfWatchers!))"
        self.journeyTitle.text = journey._title
        if let profileImageUrl = creator?._profileImage {
            ImageAPIClient.manager.loadImage(from: profileImageUrl,
                                             completionHandler: {self.profileImageView.image = $0},
                                             errorHandler: {print($0)})
        }
    }
    
    private func getEvents(for journey: Journey) {
        
        //TODO: Check if journey contains 1,2,3 or more events
        if let events = journey._events {
            for event in events.reversed() {
                DynamoDBManager.shared.loadEvent(eventId: event) { (event, error) in
                    if let error = error {
                        print(error)
                    } else {
                        self.events.append(event!)
                    }
                }
            }
        }
    }
}

extension JourneyTableViewCell: UICollectionViewDelegate {
    
}

extension JourneyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ADMozaikLayoutCell", for: indexPath) as! MozaikCollectionViewCell
        if indexPath.row < 3 {
            let imageView: UIImageView = cell.viewWithTag(1000) as! UIImageView
            let event = events[indexPath.row]
            //TODO: GET PICTURE URL OR VIDEO URL FROM DB
            if let media = event._media {
                print(media)
                S3Manager.shared.downloadManagerData(imageUID: media) { (image, error) in
                    if let error = error {
                        print(error)
                    }
                    imageView.image = image
                }
            }
            cell.howManyMoreLabel.text = ""
        } else {
            cell.mozaik.backgroundColor = UIColor.lightGray
            cell.howManyMoreLabel.text = "\(Int(truncating: (journey?._eventCount)!) - 3)"
            cell.isVideo.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
}

extension JourneyTableViewCell: ADMozaikLayoutDelegate {
    func collectonView(_ collectionView: UICollectionView, mozaik layoyt: ADMozaikLayout, geometryInfoFor section: ADMozaikLayoutSection) -> ADMozaikLayoutSectionGeometryInfo {
        let rowHeight: CGFloat = UIScreen.main.bounds.width / 4 - 14
        let width = UIScreen.main.bounds.width / 4 - 14
        let columns = [ADMozaikLayoutColumn(width: width), ADMozaikLayoutColumn(width: width), ADMozaikLayoutColumn(width: width), ADMozaikLayoutColumn(width: width)]
        let geometryInfo = ADMozaikLayoutSectionGeometryInfo(rowHeight: rowHeight,
                                                             columns: columns,
                                                             minimumInteritemSpacing: 8,
                                                             minimumLineSpacing: 8,
                                                             sectionInset: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8),
                                                             headerHeight: 0, footerHeight: 0)
        return geometryInfo
    }
    
    func collectionView(_ collectionView: UICollectionView, mozaik layout: ADMozaikLayout, mozaikSizeForItemAt indexPath: IndexPath) -> ADMozaikLayoutSize {
        if indexPath.item == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 2, numberOfRows: 2)
        }
        else if indexPath.item % 3 == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 1)
        }
        if indexPath.item % 8 == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 2, numberOfRows: 2)
        }
        else if indexPath.item % 2 == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 1)
        }
        else if indexPath.item % 1 == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 2, numberOfRows: 1)
        }
        else if indexPath.item % 6 == 0 {
            return ADMozaikLayoutSize(numberOfColumns: 3, numberOfRows: 1)
        }
        else {
            return ADMozaikLayoutSize(numberOfColumns: 1, numberOfRows: 1)
        }
    }
}
