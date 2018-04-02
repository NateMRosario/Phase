//
//  DB.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class DB {
    static func fetchContents(handler: @escaping ((_ images: [UIImage]) -> Void)) {
        DispatchQueue.global().async {
            var images = [UIImage]()
            for _ in 0...10 {
                let urlstr = "https://source.unsplash.com/random"
                ImageAPIClient.manager.loadImage(from: urlstr,
                                                 completionHandler: {images.append($0)},
                                                 errorHandler: {print($0)})
            }
            
            DispatchQueue.main.async {
                handler(images)
            }
        }
    }
}
