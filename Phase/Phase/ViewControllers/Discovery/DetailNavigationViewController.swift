//
//  DetailNavigationViewController.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class DetailNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        transitioningDelegate = self
        navigationBar.disableShadow()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

extension DetailNavigationViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimateDiscoverToDetailVC(operation: .push)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimateDiscoverToDetailVC(operation: .pop)
    }
}
