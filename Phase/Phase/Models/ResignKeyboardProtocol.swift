//
//  ResignKeyboardProtocol.swift
//  Phase
//
//  Created by C4Q on 3/29/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

protocol ResignKeyboardDelegate: class {
    func dismissKeyboard()
}

class ResignKeyboard: UIViewController {
    var delegate: ResignKeyboardDelegate?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            delegate?.dismissKeyboard()
        }
    }
}
