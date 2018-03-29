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
    
    let s3Bucket = "phase-journey-events" ///Bucket Name
    let transferManager = AWSS3TransferManager.default()
    
    func uploadManagerData(image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        guard let pngImage = UIImagePNGRepresentation(image) else { print("image is nil"); return }
        let fileName = "test.png"
        let fileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        do {
            try pngImage.write(to: fileURL)
            let uploadRequest = AWSS3TransferManagerUploadRequest()
            let imageUID = UUID().uuidString + ".png" ///Unique String
            uploadRequest?.bucket = s3Bucket
            uploadRequest?.key = imageUID
            uploadRequest?.body = fileURL
            uploadRequest?.contentType = "image/png"
            transferManager.upload(uploadRequest!).continueWith { (task) -> Any? in
                if let error = task.error {
                    print("Error, Unable to Load: \(error)")
                    completion(nil, error)
                }
                if let result = task.result {
                    print("Uploaded: \(result)")
                    completion(imageUID, nil)
                }
                return nil
            }
        } catch {
            print("File not Saved")
        }
    }
    
    func downloadManagerData(imageUID: String, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent("myImage.jpg")
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        downloadRequest?.bucket = s3Bucket
        downloadRequest?.key = imageUID
        downloadRequest?.downloadingFileURL = downloadingFileURL
        var image = UIImage()
        transferManager.download(downloadRequest!).continueWith(block: { (task) -> Any? in
            if let error = task.error {
                print(error)
                completionHandler(nil, error)
            } else {
                image = UIImage(contentsOfFile: downloadingFileURL.path)!
                completionHandler(image, nil)
            }
            return nil
        })
    }
    
    /// Used for progress tracking (Optional)
    let transferUtility = AWSS3TransferUtility.default()
    
    func uploadUtilityData() {
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
    func downloadUtilityData() {
        let expression = AWSS3TransferUtilityDownloadExpression()
        expression.progressBlock = {(task, progress) in DispatchQueue.main.async(execute: {
            // Do something e.g. Update a progress bar.
        })
        }
        var completionHandler: AWSS3TransferUtilityDownloadCompletionHandlerBlock?
        completionHandler = { (task, URL, data, error) -> Void in
            if let error = error {
                print(error.localizedDescription)
            }
            DispatchQueue.main.async(execute: {
                //                self.image = UIImage(data: data!)
                // Do something e.g. Alert a user for transfer completion.
                // On failed downloads, `error` contains the error object.
            })
        }
        
        transferUtility.downloadData(
            fromBucket: "phase-journey-events",
            key: "druid.jpg",
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
