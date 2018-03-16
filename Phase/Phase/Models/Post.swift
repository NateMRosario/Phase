//
//  Post.swift
//  Phase
//
//  Created by Clint Mejia on 3/13/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

class Post: Codable {
    var user: String
    var photos: String
//    var video: String
    var captions: String
    var postText: String
    var hashTag: [String]
}
