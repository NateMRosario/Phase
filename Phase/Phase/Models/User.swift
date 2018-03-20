//
//  User.swift
//  Phase
//
//  Created by Clint Mejia on 3/13/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

class User: Codable {
    let profileName: String
    let bio: String
    let photo: String
    let subscribed: Int
    let subscribers: Int
    let totalActivities: Int
}
