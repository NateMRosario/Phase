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
    var testArray = [Post]()

    // MARK: - Constants
    let activityView = ActivityView()
    
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
        self.activityView.activityCollectionView.dataSource = self
        self.activityView.activityCollectionView.delegate = self

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    private func addSubView() {
        self.view.addSubview(activityView)
    }
    
    private func setupView() {
        setupActivityView()
    }

    // MARK: - Contraints
    private func setupActivityView() {
        activityView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
    
}

extension ActivityViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: activityView.cellID, for: indexPath) as! ActivityCollectionViewCell
        let post = testArray[indexPath.]
        
    }
}
