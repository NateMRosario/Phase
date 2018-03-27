//
//  ActivityCarouselViewController.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class ActivityCarouselViewController: UIViewController {
    
    // MARK: - Testbed properties
    var items: [Int] = []
    var post: [Int] = [1,2,3]
    
    // MARK: - Properties
    private let carouselView = CarouselView()
    private let activityCommentView = ActivityCommentView()
    private let cellID = "ActivityCommentTableViewCell"
    
    // MARK: - Init (Dependency injection)
//    init(list: List){
//        self.journey = post
//        super.init(nibName: nil, bundle: nil)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        self.carouselView.carouselCollectionView.delegate = self
        self.carouselView.carouselCollectionView.dataSource = self
        self.activityCommentView.activityCommentTableView.delegate = self
        self.activityCommentView.activityCommentTableView.dataSource = self
        setupView()
        setActivityCommentViewZAxis()
        self.activityCommentView.activityCommentTableView.layer.borderWidth = 1
        self.activityCommentView.activityCommentTableView.layer.cornerRadius = 10
        self.activityCommentView.activityCommentTableView.layer.masksToBounds = true
        self.activityCommentView.activityCommentTableView.clipsToBounds = true
    }
    
    // MARK: - Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        setupCarouselView()
        setupActivityCommentView()
        for i in 0 ... 99 {
            items.append(i)
        }
    }
    
    private func setActivityCommentViewZAxis() {
        view.bringSubview(toFront: activityCommentView)
    }

    private func getPost() {}
    
    // MARK: - Contraints
    private func setupCarouselView() {
        self.view.addSubview(carouselView)
        carouselView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.55
            )
        }
    }
    
    func setupActivityCommentView() {
        self.view.addSubview(activityCommentView)
        activityCommentView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(view.snp.bottom).offset(-10)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(view.snp.height).multipliedBy(0.25)
        }
    }
    
}

// MARK: - iCarouselDataSource
extension ActivityCarouselViewController: iCarouselDataSource {
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
extension ActivityCarouselViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
}

// MARK: - UITableViewDelegate
extension ActivityCarouselViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource
extension ActivityCarouselViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ActivityCommentTableViewCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.clipsToBounds = true
        
        return cell
    }
}
