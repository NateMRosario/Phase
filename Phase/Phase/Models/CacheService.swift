//
//  CacheService.swift
//  Phase
//
//  Created by C4Q on 3/22/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

class CacheService {
    private init(){}
    static let manager = CacheService()
    
    private var userData: [String: AppUser] = [:]
    private var journeys: [String: Journey] = [:]
    private var images: [String: UIImage] = [:]
    private var events: [Event] = []
    
    public func add(journey: Journey, withUrlStr urlStr: String) {
        self.journeys[urlStr] = journey
    }
    public func add(image: UIImage, withUrlStr urlStr: String) {
        self.images[urlStr] = image
    }
    public func add(userData: AppUser, withID userId: String) {
        if self.userData.count > 8 {
            self.userData = [:]
        }
        self.userData[userId] = userData
    }
    
    public func add(event: Event) {
        // TODO: linear runtime, fix it
        guard !events.contains(event) else {
            return
        }
        self.events.insert(event, at: 0)
    }
    public func getJourney(fromURL urlStr: String) -> Journey? {
        if let journey = self.journeys[urlStr] {
            return journey
        }
        return nil
    }
    
    public func getImage(fromURL urlStr: String) -> UIImage? {
        if let image = images[urlStr] {
            return image
        }
        return nil
    }
    
    public func getUserData(by userId: String) -> AppUser? {
        if let user = self.userData[userId] {
            return user
        }
        return nil
    }
    
    public func getEvents() -> [Event] {
        return events
    }
    // will load previous searches into cache
//    public func configureSearches() {
//        searches = PersistenceService.manager.getPreviousSearches()
//    }
}

