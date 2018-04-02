//
//  JourneyTestViewController.swift
//  Phase
//
//  Created by Clint M on 4/2/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class JourneyTestViewController: UIViewController, UICollisionBehaviorDelegate {
    
    // MARK: - Testbed properties
    var items: [Int] = []
    var post: [Int] = [1,2,3]
    
    var hideTopView = false
    var hideMiddleView = false
    var hideBottomView = false

    // MARK: - Properties
    lazy var journeyProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "g")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor.gray.cgColor
        return imageView
    }()
    
    private let cellID = "JourneyCommentTableViewCell"
    
    private let journeyCarouselView = JourneyCarouselView()
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
        self.view.backgroundColor = UIColor.red
        self.journeyCarouselView.carouselCollectionView.delegate = self
        self.journeyCarouselView.carouselCollectionView.dataSource = self
        
        setupView()
        journeyCarouselView.carouselSlider.maximumValue = Float(picArr.count - 1)
        journeyCarouselView.carouselSlider.minimumValue = 0
        
        journeyCarouselView.carouselSlider.addTarget(self,
                                                     action: #selector(sliderValueChanged(_:)),
                                                     for: .valueChanged)
//        setupAnimatedHeader()
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {
//            self.headerView.transform = .identity
//        }, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)
//    }
    
    // MARK: - Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        journeyProfileImageView.makeCircle()
    }
    
    @objc func sliderValueChanged(_ sender: UISlider) {
        scrolledBySlider = true
        sliderValue = Int(sender.value)
    }
    
    private func setupView() {
        items = Array(0...99)
        setJourneyCarouselViewConstraints()
        setHeaderViewConstraints()
        setJourneyProfileImageViewConstraints()
    }
    
    private func setupAnimatedHeader() {
        self.headerView.transform = CGAffineTransform(translationX: -headerView.frame.width, y: 0)
    }
    
    //    private func setupjourneyCommentTableView() {
    //        journeyCommentTableView.journeyCommentTableView.tableFooterView = footerViewId
    //        journeyCommentTableView.journeyCommentTableView.tableHeaderView = headerViewID
    //        journeyCommentTableView.journeyCommentTableView.tableHeaderView?.setNeedsLayout()
    //        journeyCommentTableView.journeyCommentTableView.tableHeaderView?.layoutIfNeeded()
    //    }
    
    private func getPost() {}
    
    
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
        self.view.bringSubview(toFront: headerView)
        headerView.layer.cornerRadius = 18
        headerView.clipsToBounds = true
        headerView.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.view.snp.bottom).offset(-10)
            make.centerX.equalTo(self.view.snp.centerX)
            make.width.equalTo(self.view.snp.width).multipliedBy(0.9)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.15)
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
}

// MARK: - iCarouselDataSource
extension JourneyTestViewController: iCarouselDataSource {
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
extension JourneyTestViewController: iCarouselDelegate {
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


