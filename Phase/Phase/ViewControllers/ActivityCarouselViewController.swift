//
//  ActivityCarouselViewController.swift
//  Phase
//
//  Created by Clint M on 3/21/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class ActivityCarouselViewController: UIViewController {
    
    // MARK: - Properties
    private let carouselView = CarouselView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.carouselView.activityCollectionView.dataSource = self
        self.carouselView.activityCollectionView.delegate = self
        setupView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Functions
    private func setupView() {
        setupActivityView()
    }
    
    // MARK: - Contraints
    private func setupActivityView() {
        self.view.addSubview(carouselView)
        carouselView.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
    }
}

extension ActivityCarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: carouselView.collectionViewCellID, for: indexPath) as! CarouselCell
        return cell
    }
}

extension ActivityCarouselViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        return
    }
}

extension ActivityCarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = collectionView.bounds.width
        let itemHeight: CGFloat = collectionView.bounds.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
