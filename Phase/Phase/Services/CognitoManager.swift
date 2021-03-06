//
//  CognitoManager.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

enum CognitoError: Error {
    case noActiveUser
    case makingUserInDBError
}

class CognitoManager {
    static let shared = CognitoManager()
    private init() {
        // setup service configuration
        let serviceConfiguration = AWSServiceConfiguration(region: CognitoIdentityUserPoolRegion, credentialsProvider: nil)
        // create pool configuration
        let poolConfiguration = AWSCognitoIdentityUserPoolConfiguration(clientId: CognitoIdentityUserPoolAppClientId,
                                                                        clientSecret: CognitoIdentityUserPoolAppClientSecret,
                                                                        poolId: CognitoIdentityUserPoolId)
        // initialize user pool client
        AWSCognitoIdentityUserPool.register(with: serviceConfiguration, userPoolConfiguration: poolConfiguration, forKey: AWSCognitoUserPoolsSignInProviderKey)
        // fetch the user pool client we initialized in above step
        pool = AWSCognitoIdentityUserPool(forKey: AWSCognitoUserPoolsSignInProviderKey)
    }
    
    var pool: AWSCognitoIdentityUserPool!
    var user: AWSCognitoIdentityUser?
    var userId: String?
    
    func isUserSignedIn() -> Bool {
        user = pool.getUser()
        return user!.isSignedIn
    }
    
    func signUp(username: String, email: String, password: String, name: String, completion: @escaping (Error?) -> Void) {
        
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email)
        
        pool.signUp(username, password: password, userAttributes: [emailAttribute], validationData: nil).continueWith { (task) -> Any? in
            if let error = task.error {
                completion(error)
            } else if let result = task.result {                
                guard let userId = result.userSub else { completion(CognitoError.makingUserInDBError); return nil }
                self.userId = userId
                self.user = result.user
                completion(nil)
//                DynamoDBManager.shared.createUser(sub: result.userSub!, username: result.user.username!, completion: { (error) in
//                    if let error = error {
//                        completion(error)
//                    } else {
//                        completion(nil)
//                    }
//                })
            }
            return nil
        }
    }
    
    func signIn(username: String, password: String, completion: @escaping (Error?) -> Void) {
        user = pool.getUser()
        
        user?.getSession(username, password: password, validationData: nil)
            .continueWith(block: { (task) -> Any? in
                if let error = task.error {
                    completion(error)
                } else {
                    self.getDetails(user: self.user, completion: { (error) in
                        if let error = error {
                            completion(error)
                        } else {
                            
                            DynamoDBManager.shared.createUser(sub: self.userId!, username: username, completion: { (error) in
                                if let error = error {
                                    completion(error)
                                } else {
                                    completion(nil)
                                }
                            })
                            
                            
                        }
                    })
                }
                return nil
            })
    }
    
    func getDetails(user: AWSCognitoIdentityUser?, completion: @escaping (Error?) -> Void) {
        user?.getDetails().continueWith(block: { (task) -> Any? in
            if let error = task.error {
                completion(error)
            } else {
                if let result = task.result {
                    let attributes = result.userAttributes
                    for attribute in attributes! {
                        if let name = attribute.name, let value = attribute.value {
                            if name == "sub" {
                                self.userId = value
                                completion(nil)
                            }
                        }
                    }

                }
            }
            return nil
        })
    }
    
    func confirmAccount(username: String, code: String, completion: @escaping (Error?) -> Void) {
        user = pool.getUser(username)
        user?.confirmSignUp(code).continueWith(block: { (task) -> Any? in
            if let error = task.error {
                completion(error)
            } else if let result = task.result {
                completion(nil)
            }
            return nil
        })
    }
    
    func resendCode(username: String, completion: @escaping (Error?) -> Void) {
        user = pool.getUser(username)
        user?.resendConfirmationCode().continueWith(block: { (task) -> Any? in
            if let error = task.error {
                completion(error)
            } else {
                completion(nil)
            }
            return nil
        })
    }
    
    func signOut() {
        user = pool.getUser()
        user?.signOut()
    }
    
    func forgotPassword(username: String, completion: @escaping (Error?) -> Void) {
        user = pool.getUser(username)
        user?.forgotPassword().continueWith(block: { (task) -> Any? in
            if let error = task.error {
                completion(error)
            } else {
                completion(nil)
            }
            return nil
        })
    }
    
    
    
}
