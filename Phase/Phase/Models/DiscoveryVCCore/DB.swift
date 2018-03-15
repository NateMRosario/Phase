//
//  DB.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class DB {
    static var imageList: [UIImage] {
        let animeImages = [#imageLiteral(resourceName: "a"), #imageLiteral(resourceName: "b"), #imageLiteral(resourceName: "c"), #imageLiteral(resourceName: "darifura1"), #imageLiteral(resourceName: "darihura2"), #imageLiteral(resourceName: "violet1"), #imageLiteral(resourceName: "violet2"), #imageLiteral(resourceName: "f"), #imageLiteral(resourceName: "d"), #imageLiteral(resourceName: "e"), #imageLiteral(resourceName: "j"), #imageLiteral(resourceName: "darifura3"), #imageLiteral(resourceName: "tokikake1"), #imageLiteral(resourceName: "g")]
        let nostalgicImages = [#imageLiteral(resourceName: "nostalgic1"), #imageLiteral(resourceName: "nostalgic2"), #imageLiteral(resourceName: "nostalgic3"), #imageLiteral(resourceName: "nostalgic4")]
        return animeImages + nostalgicImages
    }
    
    static func fetchContents(handler: @escaping ((_ images: [UIImage]) -> Void)) {
        DispatchQueue.global().async {
            var images = [UIImage]()
            for _ in 0...Int(DB.getRandomNumber(min: 100, max: 300)) {
                var shuffledImageList = DB.imageList.shuffled
                var extractionImages = [UIImage]()
                for _ in 0..<shuffledImageList.count {
                    let remainingImagesCount = DB.imageList.count - extractionImages.count
                    let index = Int(DB.getRandomNumber(min: 0, max: CGFloat(remainingImagesCount)))
                    extractionImages.append(shuffledImageList[index])
                    shuffledImageList.remove(at: index)
                }
                images += extractionImages
                extractionImages = []
            }
            
            DispatchQueue.main.async {
                handler(images)
            }
        }
    }
    
    static private func getRandomNumber(min: CGFloat, max: CGFloat) -> CGFloat {
        return ( CGFloat(arc4random_uniform(UINT32_MAX)) / CGFloat(UINT32_MAX) ) * (max - min) + min
    }
}
