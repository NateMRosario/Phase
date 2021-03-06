//
//  Event.swift
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
class Event: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _eventId: String?
    var _caption: String?
    var _comments: Set<String>?
    var _creationDate: NSNumber?
    var _journey: String?
    var _media: String?
    var _numberOfLikes: NSNumber?
    var _numberOfViews: NSNumber?
    var _userId: String?
    var _viewers: Set<String>?
    
    class func dynamoDBTableName() -> String {
        
        return "phase-mobilehub-529604760-Event"
    }
    
    class func hashKeyAttribute() -> String {
        
        return "_eventId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
            "_eventId" : "eventId",
            "_caption" : "caption",
            "_comments" : "comments",
            "_creationDate" : "creationDate",
            "_journey" : "journey",
            "_media" : "media",
            "_numberOfLikes" : "numberOfLikes",
            "_numberOfViews" : "numberOfViews",
            "_userId" : "userId",
            "_viewers" : "viewers",
        ]
    }
}
