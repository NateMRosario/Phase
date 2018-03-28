//
//  WelcomeViewController.swift
//  Phase
//
//  Created by C4Q on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Pastel

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let pastelView = PastelView(frame: view.bounds)
        
        // Custom Direction
        pastelView.startPastelPoint = .topLeft
        pastelView.endPastelPoint = .bottomRight
        
        // Custom Duration
        pastelView.animationDuration = 3.0
        
        // Custom Color
        pastelView.setColors(HexStringToUIColor.appGradient)
        
        pastelView.startAnimation()
        view.insertSubview(pastelView, at: 0)
    }
}

