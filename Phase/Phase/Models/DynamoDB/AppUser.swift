//
//  AppUser.swift
//  MySampleApp
//
//
// Copyright 2018 Amazon.com, Inc. or its affiliates (Amazon). All Rights Reserved.
//
// Code generated by AWS Mobile Hub. Amazon gives unlimited permission to 
// copy, distribute and modify it.
//
// Source code generated from template: aws-my-sample-app-ios-swift v0.19
//

import Foundation
import UIKit
import AWSDynamoDB

@objcMembers
class AppUser: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _userId: String?
    var _bio: String?
    var _creationDate: NSNumber?
    var _eventsViewed: Set<String>?
    var _followerCount: NSNumber?
    var _fullName: String?
    var _headerImage: String?
    var _isPremium: NSNumber?
    var _isWatching: Set<String>?
    var _journeys: Set<String>?
    var _journeysFollowed: Set<String>?
    var _numberOfJourneys: NSNumber?
    var _profileImage: String?
    var _username: String?
    var _usersFollowed: Set<String>?
    var _watcherCount: NSNumber?
    
    class func dynamoDBTableName() -> String {
        
        return "phase-mobilehub-529604760-AppUser"
    }
    
    class func hashKeyAttribute() -> String {
        
        return "_userId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_userId" : "userId",
            "_bio" : "bio",
            "_creationDate" : "creationDate",
            "_eventsViewed" : "eventsViewed",
            "_followerCount" : "followerCount",
            "_fullName" : "fullName",
            "_headerImage" : "headerImage",
            "_isPremium" : "isPremium",
            "_isWatching" : "isWatching",
            "_journeys" : "journeys",
            "_journeysFollowed" : "journeysFollowed",
            "_numberOfJourneys" : "numberOfJourneys",
            "_profileImage" : "profileImage",
            "_username" : "username",
            "_usersFollowed" : "usersFollowed",
            "_watcherCount" : "watcherCount",
        ]
    }
}
