//
//  SplashVC.swift
//  Phase
//
//  Created by Clint M on 4/9/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {
    
    // Animations
    private let splashScreen = SplashScreen()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(splashScreen)
        splashScreen.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        splashScreen.delegate = self
        navigationController?.navigationBar.alpha = 0.0
        tabBarController?.tabBar.alpha = 0.0
        UIView.animate(withDuration: 4.0, delay: 2.0, animations: {
            self.navigationController?.navigationBar.alpha = 1.0
            self.tabBarController?.tabBar.alpha = 1.0
            
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SplashVC: SplashScreenDelegate {
    func animationEnded() {}
}
