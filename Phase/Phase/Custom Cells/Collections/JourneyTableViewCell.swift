//
//  JourneyTableViewCell.swift
//  Phase
//
//  Created by C4Q on 3/19/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import ADMozaicCollectionViewLayout
import Kingfisher

class JourneyTableViewCell: UITableViewCell {
    
    var eventids = [String]() {
        didSet {
            getEventFor(for: eventids)
        }
    }
    
    var unsortedEvents = [Event]() {
        didSet {
            print(unsortedEvents.count)
        }
    }
    
    var sortedEvents = [Event]() {
        didSet {
            print("============================================")
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
        return date.timeAgoDisplay()
    }
    
    public func configureCell(with journey: Journey, creator: AppUser?) {
        getEvents(for: journey)
        self.startDateLabel.text = convertDate(from: journey._creationDate)
        self.userName.text = creator?._username
        self.watchersLabel.text = "Watchers: \(String(describing: journey._numberOfWatchers!))"
        self.journeyTitle.text = journey._title
        if let profileImageUrl = creator?._profileImage {
            profileImageView.kf.setImage(with: URL(string: profileImageUrl))
        }
    }
    
    private func getEvents(for journey: Journey) {
        var allEventids = [String]()
        for event in journey._events! {
            if !allEventids.contains(event) {
                allEventids.append(event)
            }
        }
        if !allEventids.isEmpty {
            self.eventids = allEventids
        }
    }
    
    private func getEventFor(for events: [String]) {
        var loadedEvents = [Event]()
        for id in events {
            DynamoDBManager.shared.loadEvent(eventId: id) { (event, error) in
                if let error = error {
                    print(error)
                } else {
                    if let event = event {
                        if !loadedEvents.contains(event) {
                            loadedEvents.append(event)
                        }
                    }
                }
            }
        }
        if !loadedEvents.isEmpty {
            loadedEvents = loadedEvents.sorted(by: { (prev, next) -> Bool in
                (prev._creationDate as! Double) < (next._creationDate as! Double)
            })
        }
        self.sortedEvents = loadedEvents
        print(sortedEvents.count)
    }
    
    //    private func sortAndGetLastThreeEvents(for events: [Event]) {
    //        switch events.count {
    //        case 0:
    //            print(0)
    //        case 1:
    //            sortedEvents.append(events.first!)
    //            DispatchQueue.main.async {
    //                 self.collectionView.reloadData()
    //                print("case 1 reload")
    //            }
    //        case 2:
    //            sortedEvents.append(events[0])
    //            sortedEvents.append(events[1])
    //            DispatchQueue.main.async {
    //                self.collectionView.reloadData()
    //                 print("case 2 reload")
    //            }
    //        case 3:
    //            sortedEvents.append(events[0])
    //            sortedEvents.append(events[1])
    //            sortedEvents.append(events[2])
    //            DispatchQueue.main.async {
    //                self.collectionView.reloadData()
    //                 print("case 3 reload")
    //            }
    //        default:
    //            break
    //        }
    //    }
}

extension JourneyTableViewCell: UICollectionViewDelegate {
    
}

extension JourneyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ADMozaikLayoutCell", for: indexPath) as! MozaikCollectionViewCell
        let event = sortedEvents[indexPath.row]
        
        if indexPath.row < 3 {
            cell.configureCell(with: event)
        } else {
            cell.mozaik.backgroundColor = UIColor.lightGray
            cell.mozaik.image = nil
            cell.howManyMoreLabel.text = "\(eventids.count - 3) more"
            cell.isVideo.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortedEvents.count
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
