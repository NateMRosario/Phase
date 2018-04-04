//
//  JourneyTestViewController.swift
//  Phase
//
//  Created by Clint M on 4/2/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

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


class JourneyDetailViewController: UIViewController {
    
    // MARK: - Testbed properties
    private var comments = [EventDummyDate]() {
        didSet {
            DispatchQueue.main.async {
                self.middleView.journeyCommentTableView.reloadData()
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
    private var followersViewMoved = false
    
    // MARK: - Properties
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
    
    
    private let journeyCarouselView = JourneyCarouselView()
    private let followersView = JourneySecondMenuView()
    private let headerView = JourneyHeaderView()
    private let middleView = JourneyCommentTableView()
    private let footerView = JourneyBottomView()
    
    let picArr = [#imageLiteral(resourceName: "a1"),#imageLiteral(resourceName: "a2"),#imageLiteral(resourceName: "a3"),#imageLiteral(resourceName: "a4"),#imageLiteral(resourceName: "a5"),#imageLiteral(resourceName: "a6"),#imageLiteral(resourceName: "a7"),#imageLiteral(resourceName: "a8"),#imageLiteral(resourceName: "a9"),#imageLiteral(resourceName: "a10"),#imageLiteral(resourceName: "a11")]
    var scrolledBySlider = false
    var sliderValue: Int = 0 {
        didSet {
            journeyCarouselView.carouselCollectionView.scrollToItem(at: sliderValue, animated: false)
            journeyCarouselView.carouselCollectionView.reloadData()
        }
    }
    
    // MARK: - Init (Dependency injection)
//        init(list: List){
//            self.journey = post
//            super.init(nibName: nil, bundle: nil)
//        }
//    
//        required init?(coder aDecoder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.journeyCarouselView.carouselCollectionView.delegate = self
        self.journeyCarouselView.carouselCollectionView.dataSource = self
        self.middleView.journeyCommentTableView.delegate = self
        self.middleView.journeyCommentTableView.dataSource = self
        self.headerView.delegate = self
        self.followersView.delegate = self
        
        setupView()
        setupSlider()
        dummmyData()
        isHiddenWhenHeaderTapped()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setInitialAnimation()
        animteViewsToIdlePosition()
    }
    
    // MARK: - Overrides
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        journeyProfileImageView.makeCircle()
        headerView.addBorder(toSide: .bottom, withColor: UIColor.black.cgColor, andThickness: 1)
    }
    
    // MARK: - Functions
    private func setupView() {
        setJourneyCarouselViewConstraints()
        setHeaderViewConstraints()
        setJourneyProfileImageViewConstraints()
        setMiddleViewConstraints()
        setFooterViewConstraints()
        setFollowersConstraints()
    }
    
    private func setupSlider() {
        journeyCarouselView.carouselSlider.maximumValue = Float(picArr.count - 1)
        journeyCarouselView.carouselSlider.minimumValue = 0
        journeyCarouselView.carouselSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
    }
    
    private func getPost() {}
    
    // views are set beyoned the superview's x position
    private func setInitialAnimation() {
        self.headerView.transform = CGAffineTransform(translationX: -headerView.frame.width, y: 0)
        self.journeyProfileImageView.transform = CGAffineTransform(translationX: -headerView.frame.width, y: 0)
        self.followersView.transform = CGAffineTransform(translationX: -headerView.frame.width, y: 0)
    }
    
    // animated Views that were set by setInitialAnimation to their idle position
    private func animteViewsToIdlePosition() {
        UIView.animate(withDuration: 0.8, delay: 0.8, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
            self.headerView.transform = .identity
            self.journeyProfileImageView.transform = .identity
            self.followersView.transform = .identity
        })
        headerView.round(corners: [.topLeft, .topRight], radius: 18)
        followersView.round(corners: [.bottomLeft, .bottomRight], radius: 18)
    }
    
    // animation for header tapped animation
    private func headerViewTapped() {
        headerViewMoved = !headerViewMoved
        UIView.animate(withDuration: 0.3, animations: {
            guard self.headerView.transform == .identity else {
                self.headerView.transform = .identity
                self.headerView.round(corners: [.topRight, .topLeft], radius: 18)
                self.journeyProfileImageView.transform = .identity
                self.middleView.transform = .identity
                self.footerView.transform = .identity
                self.isHiddenWhenHeaderTapped()
                return
            }
            self.headerTappedAnimation()
            self.isHiddenWhenHeaderTapped()
            return
        })
    }
    
    // hides tableView and footerView when headerView is in its default position
    private func isHiddenWhenHeaderTapped() {
        footerView.isHidden = !headerViewMoved
        middleView.isHidden = !headerViewMoved
        followersView.isHidden = headerViewMoved
        if !headerViewMoved {
            journeyCarouselView.unBlur()
        } else {
            journeyCarouselView.blur()
        }
    }
    
    private func headerTappedAnimation() {
        headerView.round(corners: [.topRight, .topLeft], radius: 18)
        footerView.round(corners: [.bottomRight, .bottomLeft], radius: 18)
        headerView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.625)
        journeyProfileImageView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.625)
        middleView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.625)
        footerView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.625)
    }
    
    // animation for followers tapped animation
    private func followersViewTapped() {
        followersViewMoved = !followersViewMoved
        UIView.animate(withDuration: 0.3, animations: {
            guard self.followersView.transform == .identity else {
                self.followersView.transform = .identity
                self.journeyProfileImageView.transform = .identity
                self.followersView.round(corners: [.bottomRight, .bottomLeft], radius: 18)
                self.isHiddenWhenFollowerTapped()
                return
            }
            self.animateFollowersView()
            self.isHiddenWhenFollowerTapped()
            return
        })
    }
    
    // hides Header, middle and footer when Followers is tapped
    private func isHiddenWhenFollowerTapped() {
        headerView.isHidden = followersViewMoved
        if !followersViewMoved {
            journeyCarouselView.unBlur()
        } else {
            journeyCarouselView.blur()
        }
    }

    private func animateFollowersView() {
        followersView.round(corners: [.topRight, .topLeft], radius: 18)
        followersView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.779)
        journeyProfileImageView.transform = CGAffineTransform(translationX: 0, y: -self.view.frame.bounds.height * 0.625)
        
    }
    
    // selector functions
    @objc private func sliderValueChanged(_ sender: UISlider) {
        scrolledBySlider = true
        sliderValue = Int(sender.value)
    }
    
    @objc private func journeyProfileImageTapped() {}
    
    
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
        headerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-84)
            make.centerX.equalTo(self.view.snp.centerX)
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.16)
        }
    }
    
    private func setJourneyProfileImageViewConstraints() {
        self.view.addSubview(journeyProfileImageView)
        journeyProfileImageView.snp.makeConstraints { (make) in
            make.centerY.equalTo(headerView.snp.top)
            make.trailing.equalTo(headerView.snp.trailing).offset(-25)
            make.height.equalTo(headerView.snp.height).multipliedBy(0.55)
            make.width.equalTo(journeyProfileImageView.snp.height)
        }
    }
    
    private func setMiddleViewConstraints() {
        self.view.addSubview(middleView)
        middleView.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.6)
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
    
    private func setFollowersConstraints() {
        self.view.addSubview(followersView)
        followersView.snp.makeConstraints { (make) in
            make.leading.equalTo(16)
            make.trailing.equalTo(-16)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.07)
            make.top.equalTo(headerView.snp.bottom)
        }
    }
}

// MARK: - iCarouselDataSource
extension JourneyDetailViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return picArr.count
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var itemView: UIImageView
        itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: journeyCarouselView.carouselCollectionView.frame.width, height: journeyCarouselView.carouselCollectionView.frame.height))
        itemView.image = picArr[index]
        itemView.layer.masksToBounds = true
        itemView.clipsToBounds = true
        itemView.contentMode = .scaleAspectFill
        return itemView
    }
}

// MARK: - iCarouselDelegate
extension JourneyDetailViewController: iCarouselDelegate {
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

// MARK: - Custom Delegates
extension JourneyDetailViewController: JourneyCommentTableCellDelegate {
    func profileImageTapped() {}
    func replyButtonTapped() {}
}

extension JourneyDetailViewController: JourneyHeaderDelegate {
    func segueToProfileTapped() {}
    func showCommentsTapped() {
        headerViewTapped()
    }
}

extension JourneyDetailViewController: JourneySecondMenuViewDelegate {
    func showFollowersTapped() {
        followersViewTapped()
        print("followerViewTapped")
    }
}
