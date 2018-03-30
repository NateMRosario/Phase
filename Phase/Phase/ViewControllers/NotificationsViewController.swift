//
//  NotificationsViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import PageMenu
import Parchment
import SnapKit

class NotificationsViewController: UIViewController {
    
    let controller2 : TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
    let controller1 = PeopleViewController.instantiate(withStoryboard: "SearchVCs")
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // MARK: - UI Setup
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller1.title = "You"
        controller2.title = "Following"
        
        let pagingViewController = FixedPagingViewController(viewControllers: [
            controller1,
            controller2
            ])
        
        pagingViewController.borderOptions = PagingBorderOptions.visible(height: 1, zIndex: Int.max - 1, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        pagingViewController.indicatorOptions = PagingIndicatorOptions.visible(height: 5, zIndex: Int.max - 1, spacing: UIEdgeInsets.zero, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        pagingViewController.menuHorizontalAlignment = .center
        pagingViewController.menuItemSize = PagingMenuItemSize.sizeToFit(minWidth: 50, height: 40)
        pagingViewController.menuInteraction = .none
        
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        pagingViewController.didMove(toParentViewController: self)
    }
}
