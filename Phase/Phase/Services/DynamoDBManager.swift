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
        newJourney._journeyId
        newJourney._creationDate
        newJourney._isOriginal = true
        
        
        mapper.save(newTest).continueWith { (task) -> Any? in
            if let error = task.error {
                print(error)
            } else {
                print("success")
                print(task.result?.description)
                let exp = AWSDynamoDBScanExpression()
                exp.limit = 10

                mapper.scan(Test.self, expression: exp).continueWith { (task) -> Any? in
                    if let error = task.error {
                        print(error)
                    } else if let output = task.result {
                        for test in output.items {
                            print(test)
                        }
                    }
                    return nil
                }


            }
            return nil
        }
        
        
        
        //        mapper.load(Test.self, hashKey: "3123123", rangeKey: nil).continueWith { (task) -> Any? in
        //            if let error = task.error {
        //                print(error)
        //            } else {
        //                print(task.result?.description)
        //            }
        //            return nil
        //        }
        
        
        
        
    }
    
}
