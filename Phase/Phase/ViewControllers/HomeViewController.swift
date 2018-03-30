//
//  HomeViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh

class HomeViewController: UIViewController {
    
    @IBAction func goToChat(_ sender: UIBarButtonItem) {
        DynamoDBManager.shared.loadUser(userId: CognitoManager.shared.userId!) { (user, error) in
            if let error = error {
                print(error)
            } else {
                print(user!)
            }
        }
        //present(UINavigationController(rootViewController: ChatExamplesViewController()), animated: true)
    }
    
    //TODO: Add character limit
    fileprivate var layout = CollectionViewLayout(number: 1)
    let configure = CollectionViewLayout.Configuration(numberOfColumns: 1)
    fileprivate let loadingView = DGElasticPullToRefreshLoadingViewCircle()
    
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
    let loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loading.color = UIColor.red
        
//        fetchContents()
        self.homeCollectionView.alwaysBounceVertical = true
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        homeCollectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            //DO THINGS
            self?.homeCollectionView.dg_stopLoading()
            }, loadingView: loadingView)
        let img = #imageLiteral(resourceName: "085 October Silence").crop(toWidth: UIScreen.main.bounds.width, toHeight: UIScreen.main.bounds.width)!
        homeCollectionView.dg_setPullToRefreshFillColor(UIColor(patternImage: img))
        homeCollectionView.dg_setPullToRefreshBackgroundColor(homeCollectionView.backgroundColor!)
    }
    
    private func setupNavbar() {
        navigationItem.title = "Phase"
    }
    
    private func fetchContents() {
        DB.fetchContents() { [weak self] contents in
            self?.contents = contents
            self?.homeCollectionView.reloadData()
        }
    }
    
    deinit {
        homeCollectionView?.dg_removePullToRefresh()
        print("deinit")
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == contents.count{
            let cell = homeCollectionView.dequeueReusableCell(withReuseIdentifier: "loading", for: indexPath)
            cell.addSubview(loading)
            loading.snp.makeConstraints({ (make) in
                make.centerX.equalTo(cell.contentView.snp.centerX)
                make.centerY.equalTo(cell.contentView.snp.centerY)
            })
            loading.startAnimating()
            return cell
        }
        
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
    //
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    //TODO:
}

extension HomeViewController: CollectionViewDelegateLayout {
    private func numberOfColumns() -> Int {
        return 1
    }
    
    internal func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.item == contents.count{
            return CGSize(width: configure.itemWidth,height: 100)
        }
        let image = contents[indexPath.row]
        let width = configure.itemWidth
        let height = width / image.size.width * image.size.height + 49
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == contents.count{
            // loadMoreData()
        }
    }
}


