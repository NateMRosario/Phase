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
    
    func signUp(username: String, email: String, password: String) {
        
        let emailAttribute = AWSCognitoIdentityUserAttributeType(name: "email", value: email)
        
        pool.signUp(username, password: password, userAttributes: [emailAttribute], validationData: nil).continueWith { (task) -> Any? in
            if let error = task.error {
                print(error)
            } else {
                print(task.result?.description ?? "pool sign up success block reached")
            }
            return nil
        }
    }
    
    func signIn(username: String, password: String) {
        user = pool.getUser()
        
        user?.getSession(username, password: password, validationData: nil)
            .continueWith(block: { (task) -> Any? in
                if let error = task.error {
                    print(error)
                } else {
                    print(task.result?.description ?? "sign in success block reached")
                }
                return nil
            })
        
        print(user?.username ?? "no username")
        
        user?.getDetails().continueOnSuccessWith(block: { (task) -> Any? in
            if let error = task.error {
                print(error)
            } else {
                print(task.result?.description() ?? "user get details success block reached")
                DynamoDBManager.shared.createJourney()
            }
            return nil
        })
    }
    
    func signOut() {
        user = pool.getUser()
        user?.signOut()
    }
    
}
