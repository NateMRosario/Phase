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
        profileVC.tabBarItem.image = #imageLiteral(resourceName: "profile-unselected")
        profileVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "profile-seleced")
        profileVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)

        //Camera View Controller
        func newCollectionButtonPressed() {
            
        }
        
        let cameraVC = UINavigationController(rootViewController: CameraViewController())
        cameraVC.tabBarItem.image = #imageLiteral(resourceName: "camera-unseleced")
        cameraVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "camera-selected")
        cameraVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        // Discover/Search VC
        let discoverVC = DiscoveryNavViewController(rootViewController: DiscoveryViewController.instantiate(withStoryboard: "Discover"))
        discoverVC.tabBarItem.image = #imageLiteral(resourceName: "icons8-search_filled 2")
        discoverVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "icons8-search_filled")
        discoverVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        // HomeFeed VC
        let homeVC = UINavigationController(rootViewController: HomeViewController.instantiate(withStoryboard: "HomeFeed"))
        homeVC.tabBarItem.image = #imageLiteral(resourceName: "home-unselected")
        homeVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "home-selected")
        homeVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        // Login VC
        let notificationVC = UINavigationController(rootViewController: NotificationsViewController.instantiate(withStoryboard: "Notifications"))
        notificationVC.tabBarItem.image = #imageLiteral(resourceName: "alert-unseleced")
        notificationVC.tabBarItem.selectedImage = #imageLiteral(resourceName: "alert-selected")
        notificationVC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        self.setViewControllers([homeVC, discoverVC, cameraVC, notificationVC, profileVC], animated: true)
    }
}
