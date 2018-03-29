//
//  InSearchViewController.swift
//  Phase
//
//  Created by C4Q on 3/28/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class InSearchViewController: UINavigationController, UINavigationControllerDelegate {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
        
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: " ", style: .plain, target: nil, action: nil)
    }
}
