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
    let viewCell = FollowsCollectionViewCell()
    let colorCells: [UIColor] = [.blue, .red] ///Delete after AWS
    var stringArray = [String]()
    var imageArray = [UIImage]()

//    private lazy var orderedViewCell: [UICollectionViewCell] = {
//        return [nextViewController(images: [#imageLiteral(resourceName: "7-R5CLfl_400x400"),#imageLiteral(resourceName: "7-R5CLfl_400x400"),#imageLiteral(resourceName: "7-R5CLfl_400x400"),#imageLiteral(resourceName: "7-R5CLfl_400x400"),#imageLiteral(resourceName: "7-R5CLfl_400x400")], names: ["Fr0st", "The_One", "Jester", "BjornGale", "Zeldesh"]),
//                nextViewController(images: [#imageLiteral(resourceName: "nostalgic1"), #imageLiteral(resourceName: "nostalgic2"), #imageLiteral(resourceName: "nostalgic3"), #imageLiteral(resourceName: "nostalgic4")], names: ["Fantasy", "Bridges", "ClockWork", "The Expanse"])]
//    }()
//
//    private func nextViewController(images: [UIImage], names: [String]) -> UICollectionViewCell {
//        let viewCell = FollowsCollectionViewCell.init(frame: .zero)
//        viewCell.datasource = self
//        return viewCell
//    }
    
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
            view.height.equalTo(menuBar.snp.width).multipliedBy(0.15) //default :0.15
        }
        followView.snp.makeConstraints { (view) in
            view.top.equalTo(menuBar.snp.bottom)
            view.leading.trailing.bottom.equalTo(self.view)
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftConstraint.constant = scrollView.contentOffset.x / 2
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x = scrollView.contentOffset.x
        let w = scrollView.bounds.size.width
        let currentPage = Int(ceil(x/w))
        print(currentPage)
        self.stringArray = stringsForCell(index: currentPage)
        followView.pagingCollectionView.reloadData()
        
    }
    
    func stringsForCell(index: Int) -> [String] {
        switch index {
        case 0:
            return ["Fantasy", "Bridges", "ClockWork", "The Expanse"]
        case 1:
            return ["Fr0st", "The_One", "Jester", "BjornGale", "Zeldesh"]
        default:
            return [""]
        }
    }

}
extension FollowsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colorCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PagingCell", for: indexPath) as! FollowsCollectionViewCell
        let color = colorCells[indexPath.row]
        cell.backgroundColor = color
        cell.configureCell(names: stringArray, images: imageArray)
        return cell
    }
    
}
extension FollowsViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: followView.bounds.height)
    }
}

