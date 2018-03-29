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

enum CognitoError: Error {
    case noActiveUser
}

class DynamoDBManager {
    static let shared = DynamoDBManager()
    private init() {}
    
    let dynamoDB = AWSDynamoDB.default()
    let mapper = AWSDynamoDBObjectMapper.default()
}

// MARK: - AppUser Methods
extension DynamoDBManager {
    func createUser(sub: String, username: String, completion: @escaping (Error?) -> Void) {
        
        let newUser: AppUser = AppUser()
        newUser._userId = sub
        newUser._creationDate = Date().timeIntervalSinceReferenceDate as NSNumber
        newUser._followerCount = 0
        newUser._isPremium = false
        newUser._watcherCount = 0
        newUser._numberOfJourneys = 0
        newUser._username = username
        
        mapper.save(newUser) { (error) in
            if let error = error {
                completion(error)
            } else {
                print("success creating user in database")
                completion(nil)
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
    
    func updateUser(appUser: AppUser, completion: @escaping (Error?) -> Void) {
        
        let newAppUser: AppUser = appUser
        newAppUser._userId = appUser._userId
        
        mapper.save(newAppUser) { (error) in
            if let error = error {
                completion(error)
            }
        }
    }
    
    func followUser(user: AppUser, completion: @escaping (Error?) -> Void) {
        guard let userId = CognitoManager.shared.userId else {
            completion(CognitoError.noActiveUser)
            return
        }

        let userToFollow = user
        
        loadUser(userId: userId) { (user, error) in
            if let error = error {
                completion(error)
            } else if let currentUser = user {
                guard currentUser._userId != userToFollow._userId else { return }
                
                if let followingSet = currentUser._usersFollowed {
                    
                    if !followingSet.contains(userToFollow._userId!) {
                        var followingSet = followingSet
                        followingSet.insert(userToFollow._userId!)
                        
                        currentUser._usersFollowed = followingSet
                        
                        
                        self.updateUser(appUser: currentUser, completion: { (error) in
                            if let error = error {
                                completion(error)
                            } else {
                                userToFollow._followerCount = ((userToFollow._followerCount as! Int) + 1) as NSNumber
                                self.updateUser(appUser: userToFollow, completion: { (error) in
                                    if let error = error {
                                        completion(error)
                                    }
                                })
                            }
                        })

                    }
                    
                }
                
            }
        }
        
    }
    
    
}

// MARK: - Journey Methods
extension DynamoDBManager {
    func createJourney(title: String, description: String, hashtags: Set<String>?, completion: @escaping (Error?) -> Void) {
        
        let newJourney: Journey = Journey()
        newJourney._journeyId = UUID().uuidString
        newJourney._userId = CognitoManager.shared.userId!
        newJourney._creationDate = Date().timeIntervalSinceReferenceDate as NSNumber
        newJourney._isOriginal = true
        newJourney._numberOfWatchers = 0
        newJourney._eventCount = 0
        newJourney._title = title
        newJourney._description = description
        newJourney._hashtags = hashtags
        
        mapper.save(newJourney) { (error) in
            if let error = error {
                completion(error)
            } else {
                
                self.loadUser(userId: CognitoManager.shared.userId!, completion: { (user, error) in
                    if let error = error {
                        completion(error)
                    } else if let user = user {
                        
                        let userToUpdate = user
                        
                        var newSet = user._journeys ?? Set<String>()
                        newSet.insert(newJourney._journeyId!)
                        
                        userToUpdate._numberOfJourneys = ((user._numberOfJourneys as! Int) + 1) as NSNumber
                        userToUpdate._journeys = newSet
                        
                        self.updateUser(appUser: user, completion: { (error) in
                            if let error = error {
                                completion(error)
                            } else {
                                completion(nil)
                            }
                        })
                    }
                })

                print("success creating journey")
                completion(nil)
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
    
    
    func updateJourney(journey: Journey, completion: @escaping (Error?) -> Void) {
        
        let updateJourney: Journey = journey
        updateJourney._journeyId = journey._journeyId
        
        mapper.save(updateJourney) { (error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
    }
    
    func deleteJourney(journeyId: String, completion: @escaping (Error?) -> Void) {
        
        let journeyToDelete: Journey = Journey()
        journeyToDelete._journeyId = journeyId
        
        mapper.remove(journeyToDelete) { (error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
    
    func watchJourney() {
        
    }
    
}

// MARK: - Event Methods
extension DynamoDBManager {
    func createEvent(journey: Journey, image: UIImage, caption: String, completion: @escaping (Error?) -> Void) {
        
        S3Manager.shared.uploadManagerData(image: image) { (imageId, error) in
            if let error = error {
                completion(error)
            } else if let imageId = imageId {
                
                let newEvent: Event = Event()
                newEvent._eventId = UUID().uuidString
                newEvent._creationDate = Date().timeIntervalSinceReferenceDate as NSNumber
                newEvent._journey = journey._journeyId
                newEvent._userId = CognitoManager.shared.userId
                newEvent._numberOfLikes = 0
                newEvent._numberOfViews = 0
                newEvent._caption = caption
                newEvent._media = imageId
                
                self.mapper.save(newEvent) { (error) in
                    if let error = error {
                        completion(error)
                    } else {
                        var eventSet = journey._events
                        eventSet!.insert(newEvent._eventId!)
                        let newEventCount = ((journey._eventCount as! Int) + 1) as NSNumber
                        
                        let journeyToUpdate: Journey = journey
                        journeyToUpdate._eventCount = newEventCount
                        journeyToUpdate._events = eventSet
                        
                        self.updateJourney(journey: journeyToUpdate) { (error) in
                            if let error = error {
                                completion(error)
                            } else {
                                print("success adding event and updating journey")
                                completion(nil)
                            }
                        }
                    }
                }
                
            }
        }
        
    }
    
    func loadEvent(eventId: String, completion: @escaping (Event?, Error?) -> Void) {
        
        var event: Event = Event()
        event._eventId = eventId
        
        mapper.load(Event.self, hashKey: eventId, rangeKey: nil) { (loadedEvent, error) in
            if let error = error {
                completion(nil, error)
            } else if let loadedEvent = loadedEvent {
                event = loadedEvent as! Event
                completion(event, nil)
            }
        }
        
    }
    
    func deleteEvent(event: Event, completion: @escaping (Error?) -> Void) {
        
        let eventToDelete: Event = Event()
        eventToDelete._eventId = event._eventId
        
        mapper.remove(eventToDelete) { (error) in
            if let error = error {
                completion(error)
            } else {
                completion(nil)
            }
        }
        
        
    }
    
    func likeEvent(event: Event, completion: @escaping (Error?) -> Void) {
        guard let userId = CognitoManager.shared.userId else {
            completion(CognitoError.noActiveUser)
            return
        }
        
        
    }

    
}


