//
//  DiscoveryViewController.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit

class DiscoveryViewController: UIViewController {

    fileprivate(set) var selectedIndexPath = IndexPath(item: 0, section: 0)
    
    fileprivate var layout = CollectionViewLayout()
    fileprivate var contents = [UIImage]()
    
    @IBOutlet dynamic private(set) weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            layout.delegate = self
            collectionView.setCollectionViewLayout(layout, animated: false)
            collectionView.register(cellTypes: DiscoverCollectionViewCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initNavigationBar()
        fetchContents()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initNavigationBar() {
        guard let navigationBarFrame = navigationController?.navigationBar.bounds else { return }
        let searchBar = UISearchBar(frame: navigationBarFrame)
        searchBar.placeholder = "Search"
        searchBar.textField?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        searchBar.textField?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        searchBar.textField?.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder ?? "", attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.textField?.textColor = .gray
        navigationItem.titleView = searchBar
        navigationController?.navigationBar.disableShadow()
        navigationController?.navigationBar.tintColor = UIColor.white
        //        navigationController?.hidesBarsOnSwipe = true
        navigationController?.barHideOnSwipeGestureRecognizer.setTranslation(CGPoint.zero, in: view)
    }
    
    private func fetchContents() {
        DB.fetchContents() { [weak self] contents in
            self?.contents = contents
            self?.collectionView.reloadData()
        }
    }
}

extension DiscoveryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: DiscoverCollectionViewCell.self, for: indexPath)
        cell.set(image: contents[indexPath.row])
        return cell
    }
}

extension DiscoveryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailNC = DetailNavigationViewController.instantiate(withStoryboard: "DiscoverDetail")

        selectedIndexPath = indexPath
        present(detailNC, animated: true, completion: nil)
    }
}

extension DiscoveryViewController: CollectionViewDelegateLayout {
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let image = contents[indexPath.row]
        let width = CollectionViewLayout.Configuration().itemWidth
        let height = width / image.size.width * image.size.height + 79 // 49 = Cell's white space below image
        return CGSize(width: width, height: height)
    }
}
