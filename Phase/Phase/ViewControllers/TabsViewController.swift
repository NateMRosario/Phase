//
//  TabsViewController.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class TabsViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presentingViewController?.dismiss(animated: false, completion: { () in
            print("yo")
        })
        
        self.tabBar.barTintColor = UIColor.white
                
        // Profile VC
        let profileVC = ProfileViewController.instantiate(withStoryboard: "Main")
        profileVC.tabBarItem = UITabBarItem()
        profileVC.tabBarItem.title = "Profile"
        
        //Camera View Controller
        func newCollectionButtonPressed() {
            
        }
        
        let cameraVC = UINavigationController(rootViewController: CameraViewController())
        cameraVC.tabBarItem = UITabBarItem(title: "Camera", image: #imageLiteral(resourceName: "camera"), selectedImage: #imageLiteral(resourceName: "camera"))
        
        // Discover/Search VC
        let discoverVC = DiscoveryNavViewController(rootViewController: DiscoveryViewController.instantiate(withStoryboard: "Discover"))
        discoverVC.tabBarItem.title = "Discover"
        
        // HomeFeed VC
        let homeVC = UINavigationController(rootViewController: HomeViewController.instantiate(withStoryboard: "HomeFeed"))
        homeVC.tabBarItem.title = "Home"
        
        // Login VC
        let notificationVC = NotificationsViewController.instantiate(withStoryboard: "Notifications")
        notificationVC.tabBarItem.title = "Notifications"
        
        self.setViewControllers([homeVC, discoverVC, cameraVC, notificationVC, profileVC], animated: true)
    }
}
