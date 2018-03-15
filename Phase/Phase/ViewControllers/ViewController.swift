//
//  ViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/13/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController, CustomLayoutDelegate {
    
    var colors = [UIColor.red, UIColor.blue, UIColor.cyan, UIColor.green, UIColor.white, UIColor.black, UIColor.brown, UIColor.darkGray]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView?.backgroundColor = UIColor.white
        
        let layout = collectionViewLayout as! CustomLayout
        layout.delegate = self
        layout.numberOfColumns = 2
        
    }
}

extension ViewController {
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 50
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as UICollectionViewCell
        cell.contentView.backgroundColor = colors[Int(arc4random_uniform(UInt32(colors.count)))]
        return cell
    }
}

extension ViewController {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


extension ViewController {
    func collectionView(collectionView: UICollectionView, heightForItemAtIndexPath indexPath: IndexPath) -> CGFloat {
        let height = arc4random_uniform(4) + 1
        return CGFloat(height * 100)
    }
}
