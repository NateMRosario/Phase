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
//    private let commentCellId = JourneyCommentTableViewCell()
    
    
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
        self.view.backgroundColor = UIColor.cyan
        self.journeyCarouselView.carouselCollectionView.delegate = self
        self.journeyCarouselView.carouselCollectionView.dataSource = self
//        self.journeyCommentTableView.journeyCommentTableView.delegate = self
//        self.journeyCommentTableView.journeyCommentTableView.dataSource = self
        setupView()
        var offset:CGFloat = self.view.bounds.height * 0.2
        let view = addViewController(atOffset: offset, dataForVC: nil)
        self.views.append(view!)
            offset -= 50
    }
    
    // MARK: - Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
            collapsedViewController.view.frame = CGRect(x: 0.0, y: view.frame.minY, width: self.view.bounds.width, height: self.view.bounds.height * 0.8)
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
                snapPosition.y += 30
                
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
            make.height.equalTo(self.view.snp.height).multipliedBy(0.55)
        }
    }
    
}

// MARK: - iCarouselDataSource
extension JourneyCarouselViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 10
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIImageView
        if let view = view as? UIImageView {
            itemView = view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 385, height: 385))
            itemView.image = UIImage(named: "g")
            itemView.contentMode = .scaleAspectFit
            itemView.layer.masksToBounds = true
            itemView.clipsToBounds = true
            itemView.contentMode = .center
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
            
        }
        label.text = "\(items[index])"
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
    
}

//// MARK: - UITableViewDelegate
//extension JourneyCarouselViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    }
//}
//
//// MARK: - UITableViewDataSource
//extension JourneyCarouselViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 10
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JourneyCommentTableViewCell
//        cell.layer.cornerRadius = 10
//        cell.layer.masksToBounds = true
//        cell.clipsToBounds = true
//
//        return cell
//    }
//}

