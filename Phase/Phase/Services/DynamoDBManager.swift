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
}

// MARK: - AppUser Methods
extension DynamoDBManager {
    func createUser(sub: String) {
        
        let newUser: AppUser = AppUser()
        newUser._userId = sub
        newUser._creationDate = Date().timeIntervalSinceReferenceDate as NSNumber
        newUser._followerCount = 0
        newUser._isPremium = false
        newUser._watcherCount = 0
        
        mapper.save(newUser) { (error) in
            if let error = error {
                print(error)
            } else {
                print("success creating user")
            }
        }
    }
    
    func loadUser(userId: String, completion: @escaping (AppUser?, Error?) -> Void) {
        
        var user: AppUser = AppUser()
        user._userId = userId
        
        mapper.load(AppUser.self, hashKey: userId, rangeKey: nil) { (loadedUser, error) in
            if let error = error {
                completion(nil, error)
            } else if let loadedUser = loadedUser {
                user = loadedUser as! AppUser
                completion(user, nil)
            }
        }
    }
    
    func updateUser(appUser: AppUser) {
        
        let newAppUser: AppUser = AppUser()
        newAppUser._userId = appUser._userId
        
        mapper.save(newAppUser) { (error) in
            if let error = error {
                print(error)
            }
        }
        
    }
}

// MARK: - Journey Methods
extension DynamoDBManager {
    func createJourney(title: String, description: String, hashtags: Set<String>) {
        
        let newJourney: Journey = Journey()
        newJourney._journeyId = UUID().uuidString
        newJourney._userId = CognitoManager.shared.userId!
        newJourney._creationDate = Date().timeIntervalSinceReferenceDate as NSNumber
        newJourney._isOriginal = true
        newJourney._numberOfWatchers = 0
        newJourney._title = title
        newJourney._description = description
        newJourney._hashtags = hashtags
        
        mapper.save(newJourney) { (error) in
            if let error = error {
                print(error)
            } else {
                print("success creating journey")
            }
        }
        
    }
    
    func loadJourney(journeyId: String, completion: @escaping (Journey?, Error?) -> Void) {
        
        var journey: Journey = Journey()
        journey._journeyId = journeyId
        
        mapper.load(Journey.self, hashKey: journeyId, rangeKey: nil) { (loadedJourney, error) in
            if let error = error {
                completion(nil, error)
            } else if let loadedJourney = loadedJourney {
                journey = loadedJourney as! Journey
                completion(journey, nil)
            }
        }
    }
    
    
    func updateJourney(journey: Journey) {
        
        let updateJourney: Journey = journey
        updateJourney._journeyId = journey._journeyId
        updateJourney._eventCount = ((journey._eventCount as! Int) + 1) as NSNumber
        
    }
    
    func deleteJourney(journeyId: String, completion: @escaping (Error?) -> Void) {
        
        let journeyToDelete: Journey = Journey()
        journeyToDelete._journeyId = journeyId
        
        mapper.remove(journeyToDelete) { (error) in
            completion(error)
        }
    }
}

// MARK: - Event Methods
extension DynamoDBManager {
    
}


