//
//  NotificationsViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import PageMenu

class NotificationsViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []
    
    let controller2 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
    let controller1 : TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
    
    // Customize menu (Optional)
    let parameters: [CAPSPageMenuOption] = [
        .scrollMenuBackgroundColor(.white),
        .viewBackgroundColor(.white),
        .selectionIndicatorColor(ColorPalette.appBlue),
        .selectionIndicatorHeight(5),
        .selectedMenuItemLabelColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
        .bottomMenuHairlineColor(UIColor(red: 80.0/255.0, green: 80.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
        .menuItemFont(UIFont.boldSystemFont(ofSize: 17)),
        .menuHeight(40.0),
        .menuItemWidth(90.0),
        .useMenuLikeSegmentedControl(true),
        //        .centerMenuItems(false),
        .menuItemSeparatorPercentageHeight(0.0)
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - UI Setup
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray, frame: view.safeAreaLayoutGuide.layoutFrame, pageMenuOptions: parameters)
        print(view.safeAreaLayoutGuide.layoutFrame)
        
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller1.title = "You"
        controllerArray.append(controller1)

        controller2.title = "Following"
        controllerArray.append(controller2)
    }
}

