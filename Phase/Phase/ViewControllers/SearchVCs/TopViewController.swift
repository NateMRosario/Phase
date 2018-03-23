//
//  TopViewController.swift
//  Phase
//
//  Created by C4Q on 3/22/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class TopViewController: UIViewController {
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView()
        cv.dataSource = self
        cv.delegate = self
        return cv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupTableView() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.trailing.equalTo(view.snp.trailing)
            make.bottom.equalTo(view.snp.bottom)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(34)
        }
    }
}

extension TopViewController: UICollectionViewDelegate {
    
}

extension TopViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
}
