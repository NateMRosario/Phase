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
        self.tabBar.barTintColor = UIColor.white
                
        // Profile VC
        let profileVC = ProfileViewController.storyboardInstance()
        profileVC.tabBarItem = UITabBarItem()
        profileVC.tabBarItem.title = "Profile"
        
        //Camera View Controller
        let cameraVC = CameraViewController()
        cameraVC.tabBarItem = UITabBarItem(title: "Camera", image: #imageLiteral(resourceName: "camera"), selectedImage: #imageLiteral(resourceName: "camera"))
        
        // Discover/Search VC
        let discoverVC = UINavigationController(rootViewController: DiscoveryViewController.instantiate(withStoryboard: "Discover"))
        discoverVC.tabBarItem.title = "Discover"
        
        self.setViewControllers([discoverVC, cameraVC, profileVC], animated: true)
    }
}
