//
//  DiscoveryViewController.swift
//  Phase
//
//  Created by C4Q on 3/15/18.
//  Copyright © 2018 Tyler Zhao. All rights reserved.
//

import UIKit
import DGElasticPullToRefresh
import Hero

class DiscoveryViewController: UIViewController {
    
    @IBOutlet dynamic private(set) weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            layout.delegate = self
            collectionView.setCollectionViewLayout(layout, animated: false)
            collectionView.register(UINib.init(nibName: "TrendingHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "TrendingHeader")
            collectionView.register(cellTypes: DiscoverCollectionViewCell.self)
            layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
    }
    
    let urls = [
        "https://images.unsplash.com/photo-1498605380187-1800640888d5?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=ef329bb3843b73393f198e296099264c&auto=format&fit=crop&w=943&q=80",
        "https://images.unsplash.com/photo-1511066561711-5a67745b6134?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=43123b20cd0d20c5789d33c7ffbb4f70&auto=format&fit=crop&w=2134&q=80",
        "https://images.unsplash.com/photo-1520824247747-126a95298fe3?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9&s=e74039124f299f828767e569585b1dd0",
        "https://images.unsplash.com/photo-1519374086542-9ff30b72beec?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9&s=bece3c94ca262933aae9e60e607cc84a",
        "https://images.unsplash.com/photo-1519383886281-9b35dfe073bd?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9&s=d4a46e874369abf3eddf1d056b49c3d7",
        "https://images.unsplash.com/photo-1519740588306-ffbb1214223a?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9&s=b04a12a120f4066359e15d37de1a9008",
        "https://images.unsplash.com/photo-1518981070596-e270c9106c91?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9&s=b2ed5e6b9223d055afd8b40bd9150b18",
        "https://images.unsplash.com/photo-1519741414274-5b1ee71137fa?ixlib=rb-0.3.5&q=80&fm=jpg&crop=entropy&cs=tinysrgb&w=1080&fit=max&ixid=eyJhcHBfaWQiOjF9&s=a50c6de358b4a3e3e3bf52961a1b7b7d",
        "https://cdn.pixabay.com/photo/2018/02/24/20/40/fashion-3179178_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/09/30/22/16/rail-2803725_1280.jpg",
        "https://cdn.pixabay.com/photo/2017/10/12/20/15/photoshop-2845779_1280.jpg"
    ]

    fileprivate(set) var selectedIndexPath = IndexPath(item: 0, section: 0)
    fileprivate var layout = CollectionViewLayout(number: 2)
    fileprivate var contents = [UIImage]() {
        didSet {
            print(contents.count)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // Loading Indicators
    lazy fileprivate var loadingView: DGElasticPullToRefreshLoadingViewCircle = {
        let lv = DGElasticPullToRefreshLoadingViewCircle()
        return lv
    }()
    
    lazy var tailLoading: UIActivityIndicatorView = {
        let tl = UIActivityIndicatorView()
        tl.activityIndicatorViewStyle = .whiteLarge
        tl.color = .white
        return tl
    }()
    let searchBar = UISearchBar()
    
    var journeys = [Journey]() {
        didSet {
            print(journeys)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        layout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        
        initNavigationBar()
        fetchContents()
        
        self.collectionView.alwaysBounceVertical = true
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        collectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            
            self?.collectionView.dg_stopLoading()
            }, loadingView: loadingView)
        let img = #imageLiteral(resourceName: "085 October Silence").crop(toWidth: UIScreen.main.bounds.width, toHeight: UIScreen.main.bounds.width)!
        collectionView.dg_setPullToRefreshFillColor(UIColor(patternImage: img))
        collectionView.dg_setPullToRefreshBackgroundColor(collectionView.backgroundColor!)
        
        getJourneys()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func initNavigationBar() {
        guard let navigationBarFrame = navigationController?.navigationBar.bounds else { return }
        searchBar.frame = navigationBarFrame
        searchBar.placeholder = "Search"
        searchBar.textField?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        searchBar.textField?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        searchBar.textField?.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder ?? "", attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.textField?.textColor = .gray
        searchBar.textField?.isEnabled = false
        searchBar.delegate = self
        searchBar.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(pushToSearchVC)))
        
        navigationItem.titleView = searchBar
        navigationItem.backButton.title = ""
        navigationItem.backBarButtonItem?.title = ""
//        navigationController?.navigationBar.disableShadow()
//        navigationController?.navigationBar.tintColor = UIColor.white
    }
    @objc func pushToSearchVC() {
        present(InSearchViewController(rootViewController:
            SearchViewController.instantiate(withStoryboard: "SearchVCs")), animated: false)
    }
    
    private func fetchContents() {
        for _ in 0...40 {
            ImageAPIClient.manager.loadImage(from: urls[Int(arc4random_uniform(UInt32(urls.count - 1)))], completionHandler: {self.contents.append($0)}, errorHandler: {print($0)})
        }
//        DB.fetchContents() { [weak self] contents in
//            self?.contents = contents
//            self?.collectionView.reloadData()
//        }
    }
    

    private func getJourneys() {
        DynamoDBManager.shared.scanJourneys { (journeys, error) in
            if let error = error {
                print(error)
            } else {
                if let journeys = journeys {
                    self.journeys = journeys
                }
            }
        }
    }
    
    deinit {
        collectionView.dg_removePullToRefresh()
        print("deinit")
    }
}

extension DiscoveryViewController: UICollectionViewDataSource {
    
    // Why the hell isnt this being called even though headerRef height is implemented
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "TrendingHeader", for: indexPath) as! TrendingHeader
        return view
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journeys.count
        return contents.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == contents.count{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "loading", for: indexPath)
            cell.addSubview(tailLoading)
            tailLoading.snp.makeConstraints({ (make) in
                make.centerX.equalTo(cell.contentView.snp.centerX)
                make.centerY.equalTo(cell.contentView.snp.centerY)
            })
            tailLoading.startAnimating()
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(with: DiscoverCollectionViewCell.self, for: indexPath)
        cell.set(image: contents[indexPath.row])
        return cell
    }
}

extension DiscoveryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

//        let cell = collectionView.cellForItem(at: indexPath) as! DiscoverCollectionViewCell
//        let detailNC = JourneyCarouselViewController(heroID: "view\(indexPath.row)")
//        selectedIndexPath = indexPath
//        cell.image1.hero.id = "view\(indexPath.row)"
//        let nonFade = HeroModifier.forceNonFade
//        let orange = HeroModifier.backgroundColor(.orange)
//        cell.hero.modifiers = [nonFade, orange]
//        navigationController?.pushViewController(detailNC, animated: true)
    }
}

extension DiscoveryViewController: CollectionViewDelegateLayout {
    
    func numberOfColumns(indexPath: IndexPath) -> Int {
        if indexPath.item == contents.count {
            return 1
        }
        return 2
    }
    
    func sizeForItemAt(indexPath: IndexPath) -> CGSize {
//        let cell = collectionView.cellForItem(at: indexPath) as! DiscoverCollectionViewCell
        if indexPath.item == contents.count{
             return CGSize(width: UIScreen.main.bounds.width, height: 100)
        }
        
        let image = contents[indexPath.row]
        let width = CollectionViewLayout.Configuration(numberOfColumns: numberOfColumns(indexPath: indexPath)).itemWidth
        let height = width * 1.2 / image.size.width * image.size.height + 79 // 79 = Cell's clear space below image
        return CGSize(width: width, height: height)
    }
}

extension DiscoveryViewController {

}

extension DiscoveryViewController: UISearchBarDelegate {
    
}
