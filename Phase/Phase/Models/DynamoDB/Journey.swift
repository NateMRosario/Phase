//
//  Journey.swift
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
class Journey: AWSDynamoDBObjectModel, AWSDynamoDBModeling {
    
    var _journeyId: String?
    var _creationDate: NSNumber?
    var _eventCount: NSNumber?
    var _events: Set<String>?
    var _inspiredBy: String?
    var _isOriginal: NSNumber?
    var _journeysInspired: Set<String>?
    var _numberOfWatchers: NSNumber?
    var _userId: String?
    
    class func dynamoDBTableName() -> String {

        return "phase-mobilehub-529604760-Journey"
    }
    
    class func hashKeyAttribute() -> String {

        return "_journeyId"
    }
    
    override class func jsonKeyPathsByPropertyKey() -> [AnyHashable: Any] {
        return [
               "_journeyId" : "journeyId",
               "_creationDate" : "creationDate",
               "_eventCount" : "eventCount",
               "_events" : "events",
               "_inspiredBy" : "inspiredBy",
               "_isOriginal" : "isOriginal",
               "_journeysInspired" : "journeysInspired",
               "_numberOfWatchers" : "numberOfWatchers",
               "_userId" : "userId",
        ]
    }
}