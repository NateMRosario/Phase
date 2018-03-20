//
//  ActivityViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class ActivityViewController: UIViewController {
    
    // MARK: - Testbed
    private var testArray = [Post]()
    
    // MARK: - Constants
    private let activityView = ActivityView()
    private let followersView = FollowersView()
    
    // MARK: - Init (Dependency injection)
    //    init(list: List){
    //        self.shoppingList = list
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.activityView.activityCollectionView.dataSource = self
        self.activityView.activityCollectionView.delegate = self
        setupView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    private func setupView() {
        setupActivityView()
        setupFollowersView()
    }
    
    // MARK: - Contraints
    private func setupActivityView() {
        self.view.addSubview(activityView)
        activityView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.height.equalTo(view.snp.height).multipliedBy(0.7)
        }
    }
    
    private func setupFollowersView() {
        self.view.addSubview(followersView)
        followersView.snp.makeConstraints { (make) in
            make.top.equalTo(activityView.snp.bottom)
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
        }
    }
    
}

extension ActivityViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: activityView.collectionViewCellID, for: indexPath) as! ActivityCollectionViewCell
        return cell
    }
}

extension ActivityViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

extension ProfileViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = collectionView.bounds.width
        let itemHeight: CGFloat = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
