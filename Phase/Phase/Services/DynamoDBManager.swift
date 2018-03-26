//
//  DynamoDBManager.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation
import AWSCore
import AWSDynamoDB

class DynamoDBManager {
    static let shared = DynamoDBManager()
    private init() {}
    
    let mapper = AWSDynamoDBObjectMapper.default()
    
    func createJourney() {
        
        let newJourney: Journey = Journey()
        newJourney._journeyId = UUID().uuidString
        newJourney._creationDate = Date().timeIntervalSinceReferenceDate as NSNumber
        newJourney._isOriginal = true
        
        mapper.save(newJourney) { (error) in
            if let error = error {
                print(error)
            } else {
                print("success creating journey")
            }
        }
        
    }
    
    func updateJourney() {
        
    }
    
    
    
}
