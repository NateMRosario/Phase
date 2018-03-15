//
//  Animator.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class Animator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let operation: UINavigationControllerOperation
    
    init(operation: UINavigationControllerOperation) {
        self.operation = operation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) else { return }
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else { return }
        let containerView = transitionContext.containerView
        
        animateTransition(transitionContext: transitionContext, fromVC: fromVC, toVC: toVC, containerView: containerView)
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        fatalError("Has not been implemented")
    }
}

extension CGAffineTransform {
    static func make(tX: CGFloat, tY: CGFloat, scale: CGFloat) -> CGAffineTransform {
        let scaleTransform = CGAffineTransform(scaleX: scale, y: scale)
        let translationTransform = CGAffineTransform(translationX: tX, y: tY)
        let transform = scaleTransform.concatenating(translationTransform)
        return transform
    }
}
