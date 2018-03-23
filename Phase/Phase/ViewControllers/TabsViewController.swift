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
        let profileVC = ProfileViewController.instantiate(withStoryboard: "Main")
        profileVC.tabBarItem = UITabBarItem()
        profileVC.tabBarItem.title = "Profile"
        
        //Camera View Controller
        let cameraVC = CameraViewController()
        cameraVC.tabBarItem = UITabBarItem(title: "Camera", image: #imageLiteral(resourceName: "camera"), selectedImage: #imageLiteral(resourceName: "camera"))
        
        // Discover/Search VC
        let discoverVC = DiscoveryNavViewController(rootViewController: DiscoveryViewController.instantiate(withStoryboard: "Discover"))
        discoverVC.tabBarItem.title = "Discover"
        
        // HomeFeed VC
        let homeVC = UINavigationController(rootViewController: HomeViewController.instantiate(withStoryboard: "HomeFeed"))
        homeVC.tabBarItem.title = "Home"
        
         //Login VC
        let loginVC = UINavigationController(rootViewController: LoginViewController())
        loginVC.tabBarItem.title = "Auth"
        
        let followerVC = FollowsViewController()
        followerVC.tabBarItem = UITabBarItem(title: "Follows", image: nil, selectedImage: nil)
        
        
        self.setViewControllers([homeVC, discoverVC, cameraVC, profileVC, loginVC, followerVC], animated: true)
    }
}
