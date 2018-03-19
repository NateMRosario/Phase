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
        let profileVC = ProfileViewController.storyboardInstance()
        profileVC.tabBarItem = UITabBarItem()
        profileVC.tabBarItem.title = "Profile"
        
        // Discover/Search VC
        let discoverVC = UINavigationController(rootViewController: DiscoveryViewController.instantiate(withStoryboard: "Discover"))
        discoverVC.tabBarItem.title = "Discover"
        
        // Login VC
        let loginVC = UINavigationController(rootViewController: LoginViewController())
        loginVC.tabBarItem.title = "Auth"
        
        self.setViewControllers([discoverVC, profileVC, loginVC], animated: true)
    }
}
