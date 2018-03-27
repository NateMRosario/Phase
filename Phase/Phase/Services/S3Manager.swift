//
//  S3Manager.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import Foundation
import AWSS3

class S3Manager {
    static let shared = S3Manager()
    private init() {}
    
    let transferUtility = AWSS3TransferUtility.default()

    func uploadData() {
        
        let data: Data = Data() // Data to be uploaded
        
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = {(task, progress) in
            DispatchQueue.main.async(execute: {
                // Do something e.g. Update a progress bar.
            })
        }
        
        var completionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
        completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                // Do something e.g. Alert a user for transfer completion.
                // On failed uploads, `error` contains the error object.
            })
        }
        
        transferUtility.uploadData(data,
                                   bucket: "YourBucket",
                                   key: "YourFileName",
                                   contentType: "text/plain",
                                   expression: expression,
                                   completionHandler: completionHandler).continueWith {
                                    (task) -> AnyObject! in
                                    if let error = task.error {
                                        print("Error: \(error.localizedDescription)")
                                    }
                                    
                                    if let _ = task.result {
                                        // Do something with uploadTask.
                                    }
                                    return nil;
        }
    }
    
    func downloadData() {
        let expression = AWSS3TransferUtilityDownloadExpression()
        expression.progressBlock = {(task, progress) in DispatchQueue.main.async(execute: {
            // Do something e.g. Update a progress bar.
        })
        }
        
        var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
        completionHandler = { (task, URL, data, error) -> Void in
            DispatchQueue.main.async(execute: {
                // Do something e.g. Alert a user for transfer completion.
                // On failed downloads, `error` contains the error object.
            })
        }
        
        transferUtility.downloadData(
            fromBucket: "YourBucket",
            key: "YourFileName",
            expression: expression,
            completionHandler: completionHandler
            ).continueWith {
                (task) -> AnyObject! in if let error = task.error {
                    print("Error: \(error.localizedDescription)")
                }
                
                if let _ = task.result {
                    // Do something with downloadTask.
                    
                }
                return nil;
        }
    }
    
    
}
