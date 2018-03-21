//
//  Models.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/13/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation

import UIKit

enum AppError: Error {
    case noData
    case noInternet
    case invalidImage
    case codingError(rawError: Error)
    case badURL(str: String)
    case urlError(rawError: URLError)
    case otherError(rawError: Error)
}

struct NetworkHelper {
    private init() {}
    static let manager = NetworkHelper()
    let session = URLSession(configuration: .default)
    func performDataTask(with request: URLRequest, completionHandler: @escaping (Data) -> Void, errorHandler: @escaping (Error) -> Void) {
        let myDataTask = session.dataTask(with: request){(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else { errorHandler(AppError.noData); return }
                if let error = error as? URLError {
                    switch error {
                    case URLError.notConnectedToInternet:
                        errorHandler(AppError.noInternet)
                        return
                    default:
                        errorHandler(AppError.urlError(rawError: error))
                    }
                }
                else {
                    if let error = error {
                        errorHandler(AppError.otherError(rawError: error))
                    }
                }
                //                Optional (for printing data)
//                if let dataStr = String(data: data, encoding: .utf8) {
//                    print(dataStr)
//                }
                completionHandler(data)
            }
        }
        myDataTask.resume()
    }
}

struct ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func loadImage(from urlStr: String,
                   completionHandler: @escaping (UIImage) -> Void,
                   errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlStr) else {errorHandler(AppError.badURL(str: urlStr)); return}
        let completion = {(data: Data) in
            guard let onlineImage = UIImage(data: data) else {errorHandler(AppError.invalidImage); return}
            completionHandler(onlineImage)
        }
        NetworkHelper.manager.performDataTask(with: URLRequest(url: url),
                                              completionHandler: completion,
                                              errorHandler: errorHandler)
    }
}

struct Journey: Codable {
    let user: String
    let dateCreated: String
    let isOriginal: Bool
    let inspiredBy: String // Journey ID
    let postCount: Int
    let posts: [String] // Event IDs
    let numberOfWatchers: Int
    let collectionsInspired: [String]
}

struct Event: Codable {
    let user: String
    let dateCreated: String
    let collecion: String // Journey ID
    let linkToMedia: String
    let caption: String
    let numberOfLikes: Int
    let numberOfViews: Int
    let viewers: [String] // User IDs
}

struct AppUser: Codable {
    let dateCreated: String
    let username: String
    let numberOfCollections: Int
    let collections: [String] // Journey IDs
    let peopleFollowed: [String] // User IDs
    let collectionsFollowed: [String]
    let followerCount: Int
    let watcherCount: Int
    let hasViewed: [String] // Event IDs
    let isWatching: [String] // Journey IDs
    let isPremium: Bool
}
