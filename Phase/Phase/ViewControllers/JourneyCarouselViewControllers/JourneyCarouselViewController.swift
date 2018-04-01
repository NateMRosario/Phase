//
//  JourneyCarouselViewController.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class JourneyCarouselViewController: UIViewController, UICollisionBehaviorDelegate {
    
    // MARK: - Testbed properties
    var items: [Int] = []
    var post: [Int] = [1,2,3]
    
    var hideTopView = false
    var hideMiddleView = false
    var hideBottomView = false
    
    var hideFooterCell = false
    var hideCommentCell = false
    
    // Animation Properties
    var views = [UIView]()
    var animator:UIDynamicAnimator!
    var gravity:UIGravityBehavior!
    var snap:UISnapBehavior!
    var previousTouchPoint:CGPoint!
    var viewDragging = false
    var viewPinned = false
    
    // MARK: - Properties
    private let journeyCarouselView = JourneyCarouselView()
    private let journeyCommentTableView = JourneyEventDetailView()
    
    let picArr = [#imageLiteral(resourceName: "a1"),#imageLiteral(resourceName: "a2"),#imageLiteral(resourceName: "a3"),#imageLiteral(resourceName: "a4"),#imageLiteral(resourceName: "a5"),#imageLiteral(resourceName: "a6"),#imageLiteral(resourceName: "a7"),#imageLiteral(resourceName: "a8"),#imageLiteral(resourceName: "a9"),#imageLiteral(resourceName: "a10"),#imageLiteral(resourceName: "a11")]
    var scrolledBySlider = false
    var sliderValue: Int = 0 {
        didSet {
            journeyCarouselView.carouselCollectionView.scrollToItem(at: sliderValue, animated: false)
            journeyCarouselView.carouselCollectionView.reloadData()
        }
    }
    
    private let cellID = "JourneyCommentTableViewCell"
    
    // MARK: - Init (Dependency injection)
    //    init(list: List){
    //        self.journey = post
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - Lazy Variable
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAnimation()
        self.view.backgroundColor = UIColor.white
        self.journeyCarouselView.carouselCollectionView.delegate = self
        self.journeyCarouselView.carouselCollectionView.dataSource = self
        
        setupView()
        let offset:CGFloat = self.view.bounds.height * 0.2
        let view = addViewController(atOffset: offset, dataForVC: nil)
        self.views.append(view!)
        journeyCarouselView.carouselSlider.maximumValue = Float(picArr.count - 1)
        journeyCarouselView.carouselSlider.minimumValue = 0
        
        journeyCarouselView.carouselSlider.addTarget(self,
                                                     action: #selector(sliderValueChanged(_:)),
                                                     for: .valueChanged)
    }
    
    // MARK: - Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        scrolledBySlider = true
        sliderValue = Int(sender.value)
    }
    
    private func setupView() {
        items = Array(0...99)
        setJourneyCarouselViewConstraints()
    }
    
    private func setupAnimation() {
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior()
        
        animator.addBehavior(gravity)
        gravity.magnitude = 4
    }
    
    func addViewController (atOffset offset:CGFloat, dataForVC data:AnyObject?) -> UIView? {
        
        let frameForView = self.view.bounds.offsetBy(dx: 0, dy: self.view.bounds.size.height - offset)
        
        let collapsedViewController = JourneyCarouselCollapsedViewController()
        
        if let view = collapsedViewController.view {
            view.frame = frameForView
            view.layer.cornerRadius = 10
            
            
            self.addChildViewController(collapsedViewController)
            self.view.addSubview(view)
            collapsedViewController.view.frame = CGRect(x: self.view.bounds.width * 0.05, y: view.frame.minY, width: self.view.bounds.width * 0.9, height: self.view.bounds.height * 0.6)
            collapsedViewController.didMove(toParentViewController: self)
            
            
            
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(JourneyCarouselViewController.handlePan(gestureRecognizer:)))
            view.addGestureRecognizer(panGestureRecognizer)
            
            
            let collision = UICollisionBehavior(items: [view])
            collision.collisionDelegate = self
            animator.addBehavior(collision)
            
            let boundary = view.frame.origin.y + view.frame.size.height
            
            // lower boundary
            var boundaryStart = CGPoint(x: 0, y: boundary)
            var boundaryEnd = CGPoint(x: self.view.bounds.size.width, y: boundary)
            collision.addBoundary(withIdentifier: 1 as NSCopying, from: boundaryStart, to: boundaryEnd)
            
            
            // upper boundary
            boundaryStart = CGPoint(x: 0, y: 0)
            boundaryEnd = CGPoint(x: self.view.bounds.size.width, y: 0)
            collision.addBoundary(withIdentifier: 2 as NSCopying as NSCopying, from: boundaryStart, to: boundaryEnd)
            
            
            gravity.addItem(view)
            
            
            let itemBehavior = UIDynamicItemBehavior(items: [view])
            animator.addBehavior(itemBehavior)
            
            return view
        }
        return nil
    }
    
    @objc func handlePan (gestureRecognizer:UIPanGestureRecognizer) {
        
        let touchPoint = gestureRecognizer.location(in: self.view)
        let draggedView = gestureRecognizer.view!
        
        if gestureRecognizer.state == .began {
            let dragStartPoint = gestureRecognizer.location(in: draggedView)
            
            if dragStartPoint.y < 200 {
                viewDragging = true
                previousTouchPoint = touchPoint
            }
            
        } else if gestureRecognizer.state == .changed && viewDragging {
            let yOffset = previousTouchPoint.y - touchPoint.y
            
            draggedView.center = CGPoint(x: draggedView.center.x, y: draggedView.center.y - yOffset)
            previousTouchPoint = touchPoint
        }else if gestureRecognizer.state == .ended && viewDragging {
            
            pin(view: draggedView)
            addVelocity(toView: draggedView, fromGestureRecognizer: gestureRecognizer)
            
            animator.updateItem(usingCurrentState: draggedView)
            viewDragging = false
            
        }
    }
    
    func pin (view:UIView) {
        
        let viewHasReachedPinLocation = view.frame.origin.y < 100
        
        if viewHasReachedPinLocation {
            if !viewPinned {
                var snapPosition = self.view.center
                snapPosition.y -= 10
                
                snap = UISnapBehavior(item: view, snapTo: snapPosition)
                animator.addBehavior(snap)
                
                setVisibility(view: view, alpha: 0)
                
                viewPinned = true
                
                
            }
        }else{
            if viewPinned {
                animator.removeBehavior(snap)
                setVisibility(view: view, alpha: 1)
                viewPinned = false
            }
        }
    }
    
    func setVisibility (view:UIView, alpha:CGFloat) {
        for aView in views {
            if aView != view {
                aView.alpha = alpha
            }
        }
    }
    
    func addVelocity (toView view:UIView, fromGestureRecognizer panGesture:UIPanGestureRecognizer) {
        var velocity = panGesture.velocity(in: self.view)
        velocity.x = 0
        
        if let behavior = itemBehavior(forView: view) {
            behavior.addLinearVelocity(velocity, for: view)
        }
    }
    
    func itemBehavior (forView view:UIView) -> UIDynamicItemBehavior? {
        for behavior in animator.behaviors {
            if let itemBehavior = behavior as? UIDynamicItemBehavior {
                if let possibleView = itemBehavior.items.first as? UIView, possibleView == view {
                    return itemBehavior
                }
            }
        }
        
        return nil
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        if NSNumber(integerLiteral: 2).isEqual(identifier) {
            let view = item as! UIView
            pin(view: view)
        }
        
    }
    
    //    private func setupjourneyCommentTableView() {
    //        journeyCommentTableView.journeyCommentTableView.tableFooterView = footerViewId
    //        journeyCommentTableView.journeyCommentTableView.tableHeaderView = headerViewID
    //        journeyCommentTableView.journeyCommentTableView.tableHeaderView?.setNeedsLayout()
    //        journeyCommentTableView.journeyCommentTableView.tableHeaderView?.layoutIfNeeded()
    //    }
    
    private func getPost() {}
    
    private func setTableViewFooter(hidden: Bool) {
        //        guard hidden == false {
        
    }
    
    // MARK: - Contraints
    private func setJourneyCarouselViewConstraints() {
        self.view.addSubview(journeyCarouselView)
        journeyCarouselView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
}

// MARK: - iCarouselDataSource
extension JourneyCarouselViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return picArr.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        itemView = UIImageView(frame: CGRect(x: 0, y: 0,
                                             width: journeyCarouselView.carouselCollectionView.frame.width,
                                             height: journeyCarouselView.carouselCollectionView.frame.height
        ))
        itemView.image = picArr[index]
        itemView.layer.masksToBounds = true
        itemView.clipsToBounds = true
        itemView.contentMode = .scaleAspectFill
        return itemView
    }
}

// MARK: - iCarouselDelegate
extension JourneyCarouselViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        journeyCarouselView.carouselSlider.value = Float(carousel.currentItemIndex)
    }

}

