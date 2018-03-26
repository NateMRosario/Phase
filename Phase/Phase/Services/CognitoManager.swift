//
//  CognitoManager.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation
import AWSCognitoIdentityProvider

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
    
    func signUp(username: String, email: String, password: String, completion: @escaping (Error?) -> Void) {
        
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email)
        
        pool.signUp(username, password: password, userAttributes: [emailAttribute], validationData: nil).continueWith { (task) -> Any? in
            if let error = task.error {
                print(error)
                completion(error)
            } else {
                print(task.result?.description ?? "pool sign up success block reached")
                completion(nil)
            }
            return nil
        }
    }
    
    func signIn(username: String, password: String, completion: @escaping (Error?) -> Void) {
        user = pool.getUser()
        
        user?.getSession(username, password: password, validationData: nil)
            .continueWith(block: { (task) -> Any? in
                if let error = task.error {
                    print(error)
                    completion(error)
                } else {
                    print(task.result?.description ?? "sign in success block reached")
                    completion(nil)
                }
                return nil
            })
    }
    
    func getDetails() {
        user = pool.getUser()

        user?.getDetails().continueOnSuccessWith(block: { (task) -> Any? in
            if let error = task.error {
                print(error)
            } else {
                print(task.result?.description() ?? "user get details success block reached")
               // DynamoDBManager.shared.createJourney()
            }
            return nil
        })
    }
    
    func verify(username: String, code: String) {
        user = pool.getUser(username)
        user?.confirmSignUp(code)
    }
    
    func signOut() {
        user = pool.getUser()
        user?.signOut()
    }
    
    func forgotPassword(username: String) {
        user = pool.getUser(username)

    }
    
}
