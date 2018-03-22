//
//  HomeViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //TODO: Add character limit
    fileprivate var layout = CollectionViewLayout(number: 1)
    let configure = CollectionViewLayout.Configuration(numberOfColumns: 1)
    
    fileprivate var contents = [#imageLiteral(resourceName: "nostalgic1"), #imageLiteral(resourceName: "nostalgic2"), #imageLiteral(resourceName: "nostalgic3"), #imageLiteral(resourceName: "nostalgic4")]
    
    @IBOutlet weak var homeCollectionView: UICollectionView! {
        didSet {
            homeCollectionView.delegate = self
            homeCollectionView.dataSource = self
            homeCollectionView.register(cellTypes: HomeFeedCollectionViewCell.self)
            layout.delegate = self
            homeCollectionView.setCollectionViewLayout(layout, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.backgroundColor = ColorPalette.grayChateau
        
//        fetchContents()
    }
    
    private func setupNavbar() {
        navigationItem.title = "PHASE"
    }
    
    private func fetchContents() {
        DB.fetchContents() { [weak self] contents in
            self?.contents = contents
            self?.homeCollectionView.reloadData()
        }
    }
    
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: HomeFeedCollectionViewCell.self, for: indexPath)
        let content = contents[indexPath.row]
        cell.set(image: contents[indexPath.row])
        switchItUp(image: content, cell: cell)
        cell.layer.cornerRadius = 8
        return cell
    }
    ///Delete when AWS is set up
    private func switchItUp(image: UIImage, cell: HomeFeedCollectionViewCell) {
        switch image {
        case #imageLiteral(resourceName: "nostalgic1"):
            cell.postLabel.text = "Finally finished the city of Elianor"
            cell.likeLabel.text = 5.description
        case #imageLiteral(resourceName: "nostalgic2"):
            cell.postLabel.text = "Sunset overview with a bridge inbetween"
            cell.likeLabel.text = 18.description
        case #imageLiteral(resourceName: "nostalgic3"):
            cell.postLabel.text = "Something that just came to mind"
            cell.likeLabel.text = 48.description
        case #imageLiteral(resourceName: "nostalgic4"):
            cell.postLabel.text = "Dreamt of this, thought it would be perfect for my first art piece"
            cell.likeLabel.text = 150.description
        default:
            break
        }
    }
    ///
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //TODO:
}
extension HomeViewController: CollectionViewDelegateLayout {
    func numberOfColumns() -> Int {
        return 1
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        let image = contents[indexPath.row]
        let width = configure.itemWidth
        let height = width / image.size.width * image.size.height + 49
        return CGSize(width: width, height: height)
    }
}



