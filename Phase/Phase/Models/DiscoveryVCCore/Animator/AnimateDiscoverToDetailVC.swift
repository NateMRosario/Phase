//
//  AnimateDiscoverToDetailVC.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class AnimateDiscoverToDetailVC: Animator {
    private let animationScale = UIScreen.main.bounds.width / (CollectionViewLayout.Configuration(numberOfColumns: 2).itemWidth + 16) // bit small if 16*2?
    private let margin: CGFloat = 16
    
    override func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
    
    // Will trigger by DiscoverVC to DetailVC Nav
    override func animateTransition(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        switch operation {
        case .push:
            presenting(transitionContext: transitionContext, fromVC: fromVC, toVC: toVC, containerView: containerView)
        case .pop:
            dismissing(transitionContext: transitionContext, fromVC: fromVC, toVC: toVC, containerView: containerView)
        default:
            return
        }
    }
    
    private func presenting(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        // god damn nested controllers
        guard let homeVC = ((fromVC as? TabsViewController)?
            .viewControllers?[1] as? DiscoveryNavViewController)?
            .viewControllers.first as? DiscoveryViewController else { return }
        
        containerView.addSubview(toVC.view)
        
        // cell that was selected from DiscoverVC
        guard let cell = homeVC.collectionView.cellForItem(at: homeVC.selectedIndexPath) as? DiscoverCollectionViewCell else { return }
        
        // converts the coordinate of the cell to the same coordinate of DiscoverVC
        let origin = cell.convert(CGPoint.zero, to: homeVC.view)
        
        // full screen that shit
        let point = CGPoint(x: origin.x / UIScreen.main.bounds.width,
                            y: origin.y / UIScreen.main.bounds.height)
        homeVC.view.layer.setAnchorPoint(newAnchorPoint: point, forView: homeVC.view)
        
        toVC.view.alpha = 0 // dim lights on Discover VC
        
        let snapShotImageView = cell.snapShotForTransition()
        snapShotImageView.layer.setAnchorPoint(newAnchorPoint: CGPoint.zero, forView: snapShotImageView)
        snapShotImageView.frame.origin = origin
        snapShotImageView.alpha = 0
        containerView.addSubview(snapShotImageView)
        
        // Animation
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        
                        toVC.view.alpha = 1
                        
                        // DiscoverVC(after animation)
                        let transform = CGAffineTransform.make(tX: self.margin - origin.x,
                                                               tY: self.margin - origin.y + navigationBarAndStatusbarHeight,
                                                               scale: self.animationScale)
                        homeVC.view.transform = transform
                        
                        snapShotImageView.alpha = 1
                        snapShotImageView.transform = transform
        },
                       completion: { _ in
                        homeVC.view.transform = CGAffineTransform.identity
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    private func dismissing(transitionContext: UIViewControllerContextTransitioning, fromVC: UIViewController, toVC: UIViewController, containerView: UIView) {
        guard let homeVC = ((toVC as? TabsViewController)? // again, nested AF
            .viewControllers?[1] as? DiscoveryNavViewController)?
            .viewControllers.first as? DiscoveryViewController else { return }
        
        containerView.insertSubview(toVC.view, belowSubview: fromVC.view)
        
        guard let cell = homeVC.collectionView.cellForItem(at: homeVC.selectedIndexPath) as? DiscoverCollectionViewCell else { return }
        
        let origin = cell.convert(CGPoint.zero, to: homeVC.view)
        
        let transform = CGAffineTransform.make(tX: self.margin - origin.x,
                                               tY: self.margin - origin.y + navigationBarAndStatusbarHeight,
                                               scale: self.animationScale)
        homeVC.view.transform = transform
        
        let snapShotImageView = containerView.subviews.filter { type(of: $0) == UIImageView.self }.first
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext),
                       animations: {
                        // DetailVC
                        fromVC.view.alpha = 0.0
                        
                        // DiscoverVC(After animation)
                        homeVC.view.transform = CGAffineTransform.identity
                        
                        snapShotImageView?.alpha = 0
                        snapShotImageView?.transform = CGAffineTransform.identity
                        
        },
                       completion: { _ in
                        transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}
