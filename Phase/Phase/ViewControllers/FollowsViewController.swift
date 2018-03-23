//
//  FollowsViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class FollowsViewController: UIViewController {
    
    let followView = FollowsView()
    let menuBar = MenuBar()
    let colorCells: [UIColor] = [.blue, .red, .orange, .green] ///Delete after AWS
//    let images = repeatElement(#imageLiteral(resourceName: "7-R5CLfl_400x400"), count: 5)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        followView.pagingCollectionView.dataSource = self
        followView.pagingCollectionView.delegate = self
        menuBar.followsVC = self
        setupView()
        
    }
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        followView.pagingCollectionView.scrollToItem(at: indexPath, at: .right, animated: true)
    }

    fileprivate func setupView() {
        view.addSubview(menuBar)
        view.addSubview(followView)
        menuBar.snp.makeConstraints { (view) in
            view.top.equalTo(self.view.safeAreaLayoutGuide)
            view.width.equalTo(self.view)
            view.height.equalTo(menuBar.snp.width).multipliedBy(0.15)
        }
        followView.snp.makeConstraints { (view) in
            view.top.equalTo(menuBar.snp.bottom)
            view.leading.trailing.bottom.equalTo(self.view)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint.constant = scrollView.contentOffset.x / 4
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
    }

}
extension FollowsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingCell", for: indexPath)
        let color = colorCells[indexPath.row]
        cell.backgroundColor = color
        return cell
    }
    
    
}
extension FollowsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

//extension FollowsViewController: UITableViewDataSource {
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        //TODO
//        return images.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "FollowerCell", for: indexPath) as! FollowsTableViewCell
//        let image = images[indexPath.row]
//        cell.userImage.image = image
//        cell.textLabel?.text = "It works!"
//        return cell
//    }
//
//}
//extension FollowsViewController: UITableViewDelegate {
//
//}

