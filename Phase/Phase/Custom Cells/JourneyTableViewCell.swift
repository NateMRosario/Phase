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
    
    fileprivate let ADMozaikCollectionViewLayoutExampleImagesCount = 22
    
    let pics = [#imageLiteral(resourceName: "a"),#imageLiteral(resourceName: "b"),#imageLiteral(resourceName: "c"),#imageLiteral(resourceName: "d"),#imageLiteral(resourceName: "e"),#imageLiteral(resourceName: "f")]

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
            collectionView.layer.cornerRadius = 10
        }
    }
    
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
}

extension JourneyTableViewCell: UICollectionViewDelegate {
    
}

extension JourneyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ADMozaikLayoutCell", for: indexPath) as! MozaikCollectionViewCell
        if indexPath.row < 3 {
            let imageView: UIImageView = cell.viewWithTag(1000) as! UIImageView
            imageView.image = UIImage(named: "\((indexPath as NSIndexPath).item % ADMozaikCollectionViewLayoutExampleImagesCount)")
            cell.howManyMoreLabel.text = ""
        } else {
            cell.mozaik.backgroundColor = UIColor.lightGray
            cell.howManyMoreLabel.text = "32 More"
            cell.isVideo.image = nil
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
}

extension JourneyTableViewCell: ADMozaikLayoutDelegate {
    func collectonView(_ collectionView: UICollectionView, mozaik layoyt: ADMozaikLayout, geometryInfoFor section: ADMozaikLayoutSection) -> ADMozaikLayoutSectionGeometryInfo {
        let rowHeight: CGFloat = collectionView.bounds.height / 2 - 10
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
