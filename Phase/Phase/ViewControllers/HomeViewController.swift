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
    
    var events = [Event]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    @IBAction func goToChat(_ sender: UIBarButtonItem) {
        DynamoDBManager.shared.loadEvent(eventId: "B2EDE1FE-40ED-400F-B239-9D42BD526800") { (event, error) in
            if let error = error {
                print(error)
            } else if let event = event {
                print(event)
            } else {
                print("nil")
            }
        }
        
    }
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 400
            tableView.rowHeight = UITableViewAutomaticDimension
            tableView.separatorStyle = .none
        }
    }
    
    //TODO: Add character limit
    fileprivate let loadingView = DGElasticPullToRefreshLoadingViewCircle()
    let loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.color = UIColor.red
        navigationController?.hidesBarsOnSwipe = false
        
        self.tableView.alwaysBounceVertical = true
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
            tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            //DO THINGS
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        let img = #imageLiteral(resourceName: "085 October Silence").crop(toWidth: UIScreen.main.bounds.width, toHeight: UIScreen.main.bounds.width)!
        tableView.dg_setPullToRefreshFillColor(UIColor(patternImage: img))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
    }
    
    private func setupNavbar() {
        navigationItem.title = "Phase"
    }
    
    private func fetchContents() {
        DB.fetchContents() { [weak self] events in
            self?.tableView.reloadData()
        }
    }
    
    deinit {
        tableView?.dg_removePullToRefresh()
        print("deinit")
    }
}

extension HomeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.item == events.count{ // add paging
            let cell = tableView.dequeueReusableCell(withIdentifier: "loading", for: indexPath)
            cell.addSubview(loading)
            loading.snp.makeConstraints({ (make) in
                make.centerX.equalTo(cell.contentView.snp.centerX)
                make.centerY.equalTo(cell.contentView.snp.centerY)
            })
            loading.startAnimating()
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)
        cell.layer.cornerRadius = 8
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //navigationController?.pushViewController(JourneyCarouselViewController(heroID: ""), animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == events.count{
            // loadMoreData()
        }
    }
}

extension HomeViewController: PresentVCDelgate {
    func mentionsTapped() {
        self.navigationController?.pushViewController(ProfileViewController.instantiate(withStoryboard: "Main"), animated: true)
    }
    
    func hashTagTapped() {
        self.navigationController?.pushViewController(DiscoveryViewController.instantiate(withStoryboard: "Discover"), animated: true)
    }
}

