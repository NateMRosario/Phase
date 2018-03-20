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
        self.tabBar.tintColor = UIColor.white
        
        // Profile VC
        let profileVC = ProfileViewController.instantiate(withStoryboard: "Main")
        profileVC.tabBarItem = UITabBarItem()
        profileVC.tabBarItem.title = "Profile"
        
        // Discover/Search VC
        let discoverVC = DiscoveryNavViewController(rootViewController: DiscoveryViewController.instantiate(withStoryboard: "Discover"))
        discoverVC.tabBarItem.title = "Discover"
        
        // HomeFeed VC
        let homeVC = UINavigationController(rootViewController: HomeViewController.instantiate(withStoryboard: "HomeFeed"))
        homeVC.tabBarItem.title = "Home"
        
        // Login VC
        let loginVC = UINavigationController(rootViewController: LoginViewController())
        loginVC.tabBarItem.title = "Auth"
        
        self.setViewControllers([homeVC, discoverVC, profileVC, loginVC], animated: true)
    }
}
