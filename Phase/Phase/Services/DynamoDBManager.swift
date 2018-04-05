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

enum DBError: Error {
    case loadResultNil
}

class DynamoDBManager {
    static let shared = DynamoDBManager()
    private init() {}
    
    weak var delegate: DynamoDBUserActionsDelegate?
    let dynamoDB = AWSDynamoDB.default()
    let mapper = AWSDynamoDBObjectMapper.default()
}

@objc protocol DynamoDBUserActionsDelegate: class {
    @objc optional func didFollow()
    @objc optional func didUnfollow()
    @objc optional func didWatchJourney()
    @objc optional func didUnwatchJourney()
    @objc optional func didLikeEvent()
    @objc optional func didUnlikeEvent()
}

// MARK: - AppUser Methods
extension DynamoDBManager {
    func createUser(sub: String, username: String, name: String, completion: @escaping (Error?) -> Void) {
        
        let newUser: AppUser = AppUser()
        newUser._userId = sub
        newUser._creationDate = Date().timeIntervalSinceReferenceDate as NSNumber
        newUser._followerCount = 0
        newUser._isPremium = false
        newUser._watcherCount = 0
        newUser._numberOfJourneys = 0
        newUser._username = username
        newUser._fullName = name
        
        mapper.save(newUser) { (error) in
            if let error = error {
                completion(error)
            } else {
                print("success creating user in database")
                completion(nil)
            }
        }
    }
    
    func updateBio(bio: String, completion: @escaping (Error?) -> Void) {
        guard let userId = CognitoManager.shared.userId else {
            completion(CognitoError.noActiveUser)
            return
        }
        
        loadUser(userId: userId) { (user, error) in
            if let error = error {
                completion(error)
            } else if let user = user {
                
                let newUser = user
                newUser._bio = bio
                
                self.updateUser(appUser: newUser, completion: { (error) in
                    if let error = error {
                        completion(error)
                    } else {
                        completion(nil)
                    }
                })
            } else {
                print("update bio function is nil")
            }
        }
    }
    
    func loadAllUsers(completion: @escaping (AppUser?, Error?) -> Void) {
        var user: AppUser = AppUser()
        let exp = AWSDynamoDBScanExpression()
        mapper.scan(AppUser.self, expression: exp) { (loadedUser, error) in
            if let error = error {
                print(error)
                completion(nil, error)
            } else {
                if let loadedUser = loadedUser {
                    //user = loadedUser as! AppUser
                    completion(user, nil)
//                    CacheService.manager.add(userData: user, withID: user._userId!)
                }
            }
        }
    }
    
    func loadUser(userId: String, completion: @escaping (AppUser?, Error?) -> Void) {
        var user: AppUser = AppUser()
        user._userId = userId
        
        if let user = CacheService.manager.getUserData(by: userId) {
            completion(user, nil)
            print("Got user from cache")
        }
        
        mapper.load(AppUser.self, hashKey: userId, rangeKey: nil) { (loadedUser, error) in
            if let error = error {
                print(error)
                completion(nil, error)
            } else if let loadedUser = loadedUser {
                user = loadedUser as! AppUser
                completion(user, nil)
                CacheService.manager.add(userData: user, withID: userId)
            } else {
                completion(nil, DBError.loadResultNil)
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
    
    func unfollowUser(user: AppUser, completion: @escaping (Error?) -> Void) {
        guard let userId = CognitoManager.shared.userId else {completion(CognitoError.noActiveUser); return}
        let userToUnfollow = user
        loadUser(userId: userId) { (user, error) in
            if let error = error {completion(error)}
            else if let currentUser = user {
                guard currentUser._userId == userToUnfollow._userId else {return}
                if let followingSet = currentUser._usersFollowed {
                    var followingSet = followingSet
                    followingSet.remove(currentUser._userId!)
                    currentUser._usersFollowed = followingSet
                    self.updateUser(appUser: currentUser, completion: { (error) in
                        if let error = error {completion(error)}
                        else {userToUnfollow._followerCount = ((userToUnfollow._followerCount as! Int) - 1) as NSNumber
                            self.updateUser(appUser: currentUser, completion: { (error) in
                                if let error = error {completion(error)}
                                else {
                                    self.updateUser(appUser: userToUnfollow, completion: { (error) in
                                        if let error = error {
                                            completion(error)
                                        } else {
                                            self.delegate?.didUnfollow!()
                                        }
                                    })
                                }
                            })
                        }
                    })
                }
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
                                    } else {
                                        self.delegate?.didFollow!()
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
                print(error)
                completion(error)
            } else {
                print("about to load user...")
                self.loadUser(userId: CognitoManager.shared.userId!, completion: { (user, error) in
                    if let error = error {
                        print(error)
                        completion(error)
                    } else if let user = user {
                        print(user)
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
    
    func createJourneyWith(journey: Journey, completion: @escaping (Error?) -> Void) {
        
        let newJourney = journey
        
        mapper.save(newJourney) { (error) in
            if let error = error {
                print(error)
                completion(error)
            } else {
                print("about to load user...")
                self.loadUser(userId: CognitoManager.shared.userId!, completion: { (user, error) in
                    if let error = error {
                        print(error)
                        completion(error)
                    } else if let user = user {
                        print(user)
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
        
        if let journey =  CacheService.manager.getJourney(fromURL: journeyId) {
            completion(journey, nil)
            print("Got journey from cache")
        }
        
        mapper.load(Journey.self, hashKey: journeyId, rangeKey: nil) { (loadedJourney, error) in
            if let error = error {
                completion(nil, error)
            } else if let loadedJourney = loadedJourney {
                journey = loadedJourney as! Journey
                completion(journey, nil)
                CacheService.manager.add(journey: journey, withUrlStr: journeyId)
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
    
    func watchJourney(journey: Journey, completion: @escaping (Error?) -> Void) {
        guard let userId = CognitoManager.shared.userId else {
            completion(CognitoError.noActiveUser)
            return
        }
        
        loadUser(userId: userId) { (user, error) in
            if let error = error {
                completion(error)
            } else {
                if let user = user {
                    
                    let newUser = user
                    var newSet = user._isWatching ?? Set<String>()
                    newSet.insert(journey._journeyId!)
                    
                    self.updateUser(appUser: newUser, completion: { (error) in
                        if let error = error {
                            completion(error)
                        } else {
                            
                            let newJourney = journey
                            newJourney._numberOfWatchers = ((journey._numberOfWatchers as! Int) + 1) as NSNumber
                            
                            self.updateJourney(journey: newJourney, completion: { (error) in
                                if let error = error {
                                    completion(error)
                                } else {
                                    self.delegate?.didWatchJourney!()
                                    completion(nil)
                                }
                            })
                        }
                    })
                    
                    
                }
            }
        }
        

    }
    
    func mostPopularJourneys(completion: @escaping ([Journey]?, Error?) -> Void) {
        let scanExpression = AWSDynamoDBScanExpression()
        scanExpression.limit = 20
        //scanExpression.table
        scanExpression.expressionAttributeValues = [":val": 0]
        
        mapper.scan(Journey.self, expression: scanExpression) { (output, error) in
            if let error = error {
                completion(nil, error)
            } else if let output = output {
                if let journeys = output.items as? [Journey] {
                    completion(journeys, nil)
                }
            }
        }
    }
    
    func queryJourneys(completion: @escaping ([Journey]?, Error?) -> Void) {
        let expression = AWSDynamoDBQueryExpression()
        expression.keyConditionExpression = ""
        expression.limit = 10
        expression.expressionAttributeNames = ["#journeyId" : "journeyId"]
        expression.expressionAttributeValues = ["journeyId" : ""]
        expression.filterExpression = ""
        
//        mapper.query(<#T##resultClass: AnyClass##AnyClass#>, expression: <#T##AWSDynamoDBQueryExpression#>, completionHandler: <#T##((AWSDynamoDBPaginatedOutput?, Error?) -> Void)?##((AWSDynamoDBPaginatedOutput?, Error?) -> Void)?##(AWSDynamoDBPaginatedOutput?, Error?) -> Void#>)
    }
    
//    func likeJourney() {
//        guard let userId = CognitoManager.shared.userId else {
//            completion(CognitoError.noActiveUser)
//            return
//        }
//        
//        
//        
//    }
    
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
                newEvent._viewers = nil
                
                self.mapper.save(newEvent) { (error) in
                    if let error = error {
                        completion(error)
                    } else {
                        var eventSet = Set<String>()
                        if journey._events != nil {
                            eventSet = journey._events!
                        }
                        eventSet.insert(newEvent._eventId!)
                        let newEventCount = ((journey._eventCount as! Int) + 1) as NSNumber
                        
                        let journeyToUpdate: Journey = journey
                        journeyToUpdate._eventCount = newEventCount
                        journeyToUpdate._events = eventSet
                        journeyToUpdate._lastEvent = newEvent._eventId!
                        
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
        
        if let event = CacheService.manager.getEvents(by: eventId) {
            completion(event, nil)
        }
        
        mapper.load(Event.self, hashKey: eventId, rangeKey: nil) { (loadedEvent, error) in
            if let error = error {
                completion(nil, error)
            } else if let loadedEvent = loadedEvent {
                let event = loadedEvent as! Event
                completion(event, nil)
                CacheService.manager.add(event: event, withEventID: eventId)
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
        guard let _ = CognitoManager.shared.userId else {
            completion(CognitoError.noActiveUser)
            return
        }
        
        let newEvent = event
        newEvent._numberOfLikes = ((event._numberOfLikes as! Int) + 1) as NSNumber
        
        mapper.save(newEvent) { (error) in
            if let error = error {
                completion(error)
            } else {
                self.delegate?.didLikeEvent!()
                completion(nil)
            }
        }
        
        
        
    }

    
}


