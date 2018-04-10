//
//  JourneyDetailViewController.swift
//  Phase
//
//  Created by Clint M on 4/2/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class EventDummyDate {
    var _userId: String
    var _eventId: String
    var _caption: String
    var _media: String
    
    init(userId: String, creationDate: String, caption: String, media: String) {
        self._userId = userId
        self._eventId = creationDate
        self._caption = caption
        self._media = media
    }
}


class JourneyDetailViewController: UIViewController, UICollisionBehaviorDelegate {
    
    // MARK: - Testbed properties
    private var comments = [EventDummyDate]() {
        didSet {
            DispatchQueue.main.async {
                self.middleView.journeyCommentTableView.reloadData()
                self.headerView.configureHeaderViewCommentsCountLabel(with: self.comments.count)
            }
            
        }
    }
    
    private func dummmyData() {
        let event0 = EventDummyDate(userId: "Nate", creationDate: "2h", caption: "Cool stuff, bruh! 21! 21! 21! 21!", media: "man4.jpg")
        let event1 = EventDummyDate(userId: "Clint", creationDate: "1h 39m", caption: "Prayer hands", media: "man5.jpg")
        let event2 = EventDummyDate(userId: "Ka$hMoney", creationDate: "1h 30m", caption: "Premium, yo! $$$$ Yields!", media: "man1.jpg")
        let event3 = EventDummyDate(userId: "Reiaz", creationDate: "30m", caption: "You're making the coach cry", media: "man2.jpg")
        
        comments.append(event0)
        comments.append(event1)
        comments.append(event2)
        comments.append(event3)
    }
    
    private var headerViewMoved = false
    private var backGroundBlurred = false
    
    // MARK: - Lazy Properties
    lazy private var journeyProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "g")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(journeyProfileImageTapped))
        imageView.addGestureRecognizer(tapRecognizer)
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private let cellID = "JourneyCommentTableViewCell"
    
    // MARK: - Instances
    private let journeyCarouselView = JourneyCarouselView()
    private let headerView = JourneyHeaderView()
    private let middleView = JourneyCommentTableView()
    private let footerView = JourneyBottomView()
    private let followersView = JourneyFollowersDetailView()
    
    var scrolledBySlider = false
    var sliderValue: Int = 0 {
        didSet {
            journeyCarouselView.carouselCollectionView.scrollToItem(at: sliderValue, animated: false)
            journeyCarouselView.carouselCollectionView.reloadData()
        }
    }
    
    var journey: Journey!
    
    private func loadJourney() {
        guard let eventIds = journey._events else { return }
        for id in eventIds {
            DynamoDBManager.shared.loadEvent(eventId: id, completion: { (event, error) in
                if let error = error {
                    
                } else if let event = event {
                    if !self.events.contains(event) {
                        self.events.append(event)
                    }
                }
            })
        }
        self.events.sort{ ($0._creationDate as! Double) <  ($1._creationDate as! Double) }
    }
    
    private func loadProfileImage() {
        var currentUser = AppUser()
        guard let userId = journey._userId else { return }
        DynamoDBManager.shared.loadUser(userId: userId) { (user, error) in
            if let error = error {
                print(error)
            }
            currentUser = user
        }
        guard let imageLink = currentUser?._profileImage else { return journeyProfileImageView.image = #imageLiteral(resourceName: "profile-unselected") }
        print("\(imageLink)")
        let imageUrl = URL(string: "https://s3.amazonaws.com/phase-journey-events/\(imageLink)")
        
        journeyProfileImageView.kf.indicatorType = .activity
        journeyProfileImageView.kf.setImage(with: imageUrl, placeholder: #imageLiteral(resourceName: "profile-unselected"), options: nil, progressBlock: nil, completionHandler: nil)
    }

    private var didSort = false {
        didSet {
            DispatchQueue.main.async {
                self.journeyCarouselView.carouselCollectionView.reloadData()
                self.journeyCarouselView.carouselCollectionView.scrollToItem(at: self.events.count, animated: false)
            }
        }
    }
    
    var events = [Event]() {
        didSet {
            if events.count == journey._eventCount as! Int && didSort == false {
                let sortedEvents = events.sorted() { ($0._creationDate as! Double) < ($1._creationDate as! Double) }
                self.events = sortedEvents
                didSort = true
            }
            DispatchQueue.main.async {
                self.journeyCarouselView.carouselCollectionView.reloadData()
                self.journeyCarouselView.carouselSlider.maximumValue = Float(self.events.count-1)
                self.journeyCarouselView.configureCarouselSliderButtons(with: self.events.first?._creationDate, and: self.checkForNewJourney())
                self.journeyCarouselView.configureCarouselCounter(with: self.events.count)
            }
        }
    }
    
    // MARK: - Init (Dependency injection)
    init(journey: Journey){
        self.journey = journey
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        loadJourney()
        loadProfileImage()
        self.journeyCarouselView.carouselCollectionView.delegate = self
        self.journeyCarouselView.carouselCollectionView.dataSource = self
        self.middleView.journeyCommentTableView.delegate = self
        self.middleView.journeyCommentTableView.dataSource = self
        self.headerView.delegate = self
        self.middleView.delegate = self
        self.footerView.commentTextField.delegate = self
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:))))
        
        configureNavBar()
        setupView()
        setupSlider()
        dummmyData()
        isHiddenWhenHeaderThinButtonTapped()
        keyboardNotifications()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setInitialAnimation()
        animteViewsToIdlePosition()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        resetViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Overrides
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        journeyProfileImageView.makeCircle()
        headerView.addBorder(toSide: .bottom, withColor: UIColor.black.cgColor, andThickness: 2)
    }
    
    // MARK: - Functions
    private func setupView() {
        setJourneyCarouselViewConstraints()
        setHeaderViewConstraints()
        headerView.configureHeaderView(with: journey)
        setJourneyProfileImageViewConstraints()
        setMiddleViewConstraints()
        setFooterViewConstraints()
        setFollowersViewConstraints()
    }
    
    private func keyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(JourneyDetailViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(JourneyDetailViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0{
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0{
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    private func configureNavBar() {
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationItem.title = "Journey"
        navigationItem.title = "\(self.journey._title ?? "Journey")"
        //        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Subscribe", style: .plain, target: self, action: #selector(subscribeButtonTapped))
    }
    
    private func resetViews() {
        headerViewMoved = false
        headerView.transform = .identity
        middleView.transform = .identity
        middleView.isHidden = !headerViewMoved
        footerView.transform = .identity
        footerView.isHidden = !headerViewMoved
        followersView.transform = .identity
        followersView.isHidden = !headerViewMoved
        journeyProfileImageView.transform = .identity
        headerView.journeyCommentsUpButton.transform = .identity
        headerView.journeyFollowersUpButton.transform = .identity
        headerView.round(corners: .allCorners, radius: 18)
        
    }
    
    private func checkForNewJourney() -> NSNumber? {
        guard events.count > 1 else { return nil }
        let date = Date()
        guard date.timePosted(from: events.first?._creationDate) != date.timePosted(from: events.last?._creationDate) else { return nil }
        return events.last?._creationDate
    }
    
    private func setupSlider() {
        journeyCarouselView.carouselSlider.maximumValue = Float(events.count-1)
        journeyCarouselView.carouselSlider.minimumValue = 0
        journeyCarouselView.carouselSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    // views are set beyoned the superview's x position
    private func setInitialAnimation() {
        self.headerView.transform = CGAffineTransform(translationX: -(headerView.frame.width + 100), y: 0)
        self.journeyProfileImageView.transform = CGAffineTransform(translationX: -(headerView.frame.width + 100), y: 0)
    }
    
    // animated Views that were set by setInitialAnimation to their idle position
    private func animteViewsToIdlePosition() {
        headerView.isHidden = false
        journeyProfileImageView.isHidden = false
        UIView.animate(withDuration: 0.8, delay: 0.05, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.headerView.transform = .identity
            self.journeyProfileImageView.transform = .identity
        })
        headerView.round(corners: .allCorners, radius: 18)
    }
    
    // animation for header tapped animation
    private func headerThinButtonTapped() {
        headerViewMoved = !headerViewMoved
        UIView.animate(withDuration: 0.3, animations: {
            guard self.headerView.transform == .identity else {
                self.resetViews()
                return self.journeyCarouselView.unBlur()
            }
            self.headerTappedAnimation()
            self.journeyCarouselView.blur()
            self.isHiddenWhenHeaderThinButtonTapped()
        })
    }
    
    // hides tableView and footerView when headerView is in its default position
    private func isHiddenWhenHeaderThinButtonTapped() {
        followersView.isHidden = true
        footerView.isHidden = !headerViewMoved
        middleView.isHidden = !headerViewMoved
//        blurBackground()
    }
    
    private func commentsTapped() {
        guard self.headerViewMoved != false else {
            UIView.animate(withDuration: 0.3, animations: {
                self.headerTappedAnimation()
                self.middleView.isHidden = false
                self.followersView.isHidden = true
                self.footerView.isHidden = false
                self.journeyCarouselView.blur()
            })
            return
        }
        //if headerMoved = false && transform != .identity
        guard self.headerViewMoved != false && self.middleView.isHidden == true else {
            UIView.animate(withDuration: 0.3, animations: {
                self.resetViews()
                self.journeyCarouselView.unBlur()
            })
            return
        }
        if self.headerViewMoved == true && self.followersView.isHidden == false {
            UIView.animate(withDuration: 0.3, animations: {
                self.middleView.isHidden = false
                self.footerView.isHidden = false
                self.followersView.isHidden = true
                self.headerView.journeyCommentsUpButton.transform = CGAffineTransform(rotationAngle: self.radians(degrees: 180))
                self.headerView.journeyFollowersUpButton.transform = .identity
            })
        }
    }
    
    private func followersTapped() {
        guard self.headerViewMoved != false else {
            UIView.animate(withDuration: 0.3, animations: {
                self.headerView.round(corners: [.topRight, .topLeft], radius: 18)
                self.followersView.round(corners: [.bottomRight, .bottomLeft], radius: 18)
                self.headerView.journeyFollowersUpButton.transform = CGAffineTransform(rotationAngle: self.radians(degrees: 180))
                self.headerView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
                self.journeyProfileImageView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
                self.middleView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
                self.footerView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
                self.followersView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
                self.isHiddenWhenFollowersTapped()
                self.journeyCarouselView.blur()
                self.headerViewMoved = true
            })
            return
        }
        guard self.followersView.isHidden != true else {
            UIView.animate(withDuration: 0.3, animations: {
                self.followersView.isHidden = false
                self.middleView.isHidden = true
                self.footerView.isHidden = true
                self.followersView.round(corners: [.bottomRight, .bottomLeft], radius: 18)
                self.headerView.journeyFollowersUpButton.transform = CGAffineTransform(rotationAngle: self.radians(degrees: 180))
                self.headerView.journeyCommentsUpButton.transform = .identity
            })
            return
        }
        guard self.headerViewMoved != true && self.followersView.isHidden == true else {
            print("\(headerViewMoved == true) \(self.followersView.isHidden != true)")
            UIView.animate(withDuration: 0.3, animations: {
                self.resetViews()
                self.self.journeyCarouselView.unBlur()
            })
            return
        }
    }
    
    
    private func isHiddenWhenFollowersTapped() {
        followersView.isHidden = false
        footerView.isHidden = true
        middleView.isHidden = true
        blurBackground()
    }
    
    private func blurBackground(){
        guard backGroundBlurred == true else { backGroundBlurred = true; return journeyCarouselView.blur() }
        backGroundBlurred = false
        return journeyCarouselView.unBlur()
    }
    
    private func headerTappedAnimation() {
        headerViewMoved = true
        headerView.round(corners: [.topRight, .topLeft], radius: 18)
        footerView.round(corners: [.bottomRight, .bottomLeft], radius: 18)
        headerView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
        journeyProfileImageView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
        middleView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
        footerView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
        followersView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.55)
        headerView.journeyCommentsUpButton.transform = CGAffineTransform(rotationAngle: self.radians(degrees: 180))
    }
    
    private func radians(degrees: Double) -> CGFloat {
        return CGFloat(degrees * .pi / degrees)
    }
    
    // selector functions
    @objc private func sliderValueChanged(_ sender: UISlider) { 
        scrolledBySlider = true
        sliderValue = Int(sender.value)
        print("slider value is \(Int(sender.value)) ---")
    }
    
    @objc private func journeyProfileImageTapped() {
//        let profileVC = ProfileViewController(loadSelectedUser: journey._userId!)
//        navigationController?.pushViewController(profileVC!, animated: true)
    }
    
    @objc private func subscribeButtonTapped() {
        DynamoDBManager.shared.watchJourney(journey: self.journey) { (error) in
            if let _ = error {
                DispatchQueue.main.async {
                    self.showAlert(title: "Error", message: "Could not subscribe at this time.  Please try again later.")
                }
            } else {
                DispatchQueue.main.async {
                    self.showAlert(title: "Success", message: "You have subscribed to this journey.")
                }            }
        }
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
    
    private func setHeaderViewConstraints() {
        self.view.addSubview(headerView)
        headerView.isHidden = true
        headerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.180)
        }
    }
    
    private func setJourneyProfileImageViewConstraints() {
        self.view.addSubview(journeyProfileImageView)
        journeyProfileImageView.isHidden = true
        journeyProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView.snp.top)
            make.trailing.equalTo(headerView.snp.trailing).offset(-25)
            //            make.height.equalTo(headerView.snp.height).multipliedBy(0.1)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.081)
            make.width.equalTo(journeyProfileImageView.snp.height)
        }
    }
    
    private func setMiddleViewConstraints() {
        self.view.addSubview(middleView)
        middleView.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.48)
            make.centerX.equalTo(headerView.snp.centerX)
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
    private func setFooterViewConstraints() {
        self.view.addSubview(footerView)
        footerView.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(footerView.commentProfileImageView.snp.height).multipliedBy(1.75)
            make.centerX.equalTo(headerView.snp.centerX)
            make.top.equalTo(middleView.snp.bottom)
        }
    }
    
    private func setFollowersViewConstraints() {
        self.view.addSubview(followersView)
        self.followersView.isHidden = true
        followersView.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.48)
            make.centerX.equalTo(headerView.snp.centerX)
            make.top.equalTo(headerView.snp.bottom)
        }
    }
    
}

// MARK: - iCarouselDataSource
extension JourneyDetailViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        //        return picArr.count
        print("events.count \(events.count)")
        return events.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: journeyCarouselView.carouselCollectionView.frame.width, height: journeyCarouselView.carouselCollectionView.frame.height))
        //        itemView.image = picArr[index]
        let event = events[index]
        let url = URL(string: "https://s3.amazonaws.com/phase-journey-events/\(event._media!)")
        itemView.kf.indicatorType = .activity
        itemView.kf.setImage(with: url, placeholder: nil, options: nil, progressBlock: nil, completionHandler: nil)
        itemView.layer.masksToBounds = true
        itemView.clipsToBounds = true
        itemView.contentMode = .scaleAspectFill
        
        return itemView
    }
}

// MARK: - iCarouselDelegate
extension JourneyDetailViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        switch option {
        case .wrap:
            return 0.0 // note: 0.0 if you want to disable wrap
        case .spacing:
            return value * 1.1
        case .count:
            return CGFloat(events.count)
        default:
            return value
        }
    }
    
    func carouselCurrentItemIndexDidChange(_ carousel: iCarousel) {
        journeyCarouselView.carouselSlider.value = Float(carousel.currentItemIndex)
        let currentIndex = carousel.currentItemIndex
        let event = events[currentIndex]
        self.headerView.journeyCaptionLabel.text = event._caption ?? ""

    }
    
}

// MARK: - MiddleView TableViewDelegate
extension JourneyDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: -  MiddleView UITableViewDataSource
extension JourneyDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JourneyCommentTableViewCell
        cell.configureCell(with: comments[indexPath.row])
        cell.selectionStyle = .none
        cell.delegate = self
        return cell
    }
}

// MARK: - TextField Delegate
extension JourneyDetailViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        //move textfields up
        let myScreenRect: CGRect = UIScreen.main.bounds
        let keyboardHeight : CGFloat = 216
        
        UIView.beginAnimations( "animateView", context: nil)
        var movementDuration:TimeInterval = 0.35
        var needToMove: CGFloat = 0
        
        var frame : CGRect = self.view.frame
        if (textField.frame.origin.y + textField.frame.size.height + UIApplication.shared.statusBarFrame.size.height > (myScreenRect.size.height - keyboardHeight - 30)) {
            needToMove = (textField.frame.origin.y + textField.frame.size.height + UIApplication.shared.statusBarFrame.size.height) - (myScreenRect.size.height - keyboardHeight - 30);
        }
        
        frame.origin.y = -needToMove
        self.view.frame = frame
        UIView.commitAnimations()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.footerView.commentTextField.resignFirstResponder()
        return true
    }
}

extension JourneyDetailViewController: UIGestureRecognizerDelegate {
}

// MARK: - Custom Delegates
extension JourneyDetailViewController: JourneyCommentTableCellDelegate {
    func profileImageTapped() {}
    func replyButtonTapped() {}
}

extension JourneyDetailViewController: JourneyHeaderDelegate {
    func showFollowersTapped() {
        followersTapped()
    }
    func segueToProfileTapped() {}
    func showCommentsTapped() {
        commentsTapped()
    }
    func thinButtonTapped() {
        headerThinButtonTapped()
    }
}

extension JourneyDetailViewController: JourneyCommentTableViewDelegate {
    func refreshTableView() {
        self.middleView.journeyCommentTableView.reloadData()
        self.middleView.journeyCommentTableView.refreshControl?.endRefreshing()
    }
}
