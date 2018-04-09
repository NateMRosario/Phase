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
        present(UINavigationController(rootViewController: ChatExamplesViewController()), animated: true)
    }
    
    fileprivate var layout = CollectionViewLayout(number: 1)
    let configure = CollectionViewLayout.Configuration(numberOfColumns: 1)
    fileprivate let loadingView = DGElasticPullToRefreshLoadingViewCircle()
    let emptyView = HomeEmptyView()
    
    fileprivate var contents = [#imageLiteral(resourceName: "a11"), #imageLiteral(resourceName: "nostalgic1"), #imageLiteral(resourceName: "nostalgic2"), #imageLiteral(resourceName: "nostalgic3"), #imageLiteral(resourceName: "nostalgic4")]
    
    var appUser = AppUser() 
    var journeysFollowed = [Journey]()
    
    var appEvents = Set<Event>() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.setNeedsLayout()
            }
        }
    }
    
    var eventIDs = Set<String>() {
        didSet {
            for id in eventIDs {
                DynamoDBManager.shared.loadEvent(eventId: id, completion: { (event, error) in
                    if let error = error {
                        print(error)
                    }
                    guard let event = event else {print("event in eventIDs");return}
                    if !self.appEvents.contains(event) {
                        self.appEvents.insert(event)
                    }
                })
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
    
    let loading = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loading.color = UIColor.red
        navigationController?.hidesBarsOnSwipe = false
        
        self.tableView.alwaysBounceVertical = true
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
            tableView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
                for id in (self?.eventIDs)! {
                    DynamoDBManager.shared.loadEvent(eventId: id, completion: { (event, error) in
                        if let error = error {
                            print(error)
                        }
                        guard let event = event else {print("event in eventIDs");return}
                        self?.appEvents.insert(event)
                    })
                }
                
                
                self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        let img = #imageLiteral(resourceName: "085 October Silence").crop(toWidth: UIScreen.main.bounds.width, toHeight: UIScreen.main.bounds.width)!
        tableView.dg_setPullToRefreshFillColor(UIColor(patternImage: img))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        tableView.dataSource = self
        tableView.delegate = self
        let nib = UINib(nibName: "HomeFeedTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "HomeFeedCell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        fetchCurrentUser()
        tableView.reloadData()
    }
    
    private func setupNavbar() {
        navigationItem.title = "Phase"
    }
    private func fetchCurrentUser() {
        DynamoDBManager.shared.loadUser(userId: CognitoManager.shared.userId!) { (user, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let user = user{
                self.appUser = user
                self.fetchJourney()
            }
        }
    }

    private func fetchJourney() {
        var totalJourneys = Set<Journey>() {
            didSet {
                for journey in totalJourneys {
                    guard let eventID = journey._lastEvent else {print("eventID");return}
                    self.eventIDs.insert(eventID)
                }
            }
        }
        if usersFollowedJourneys().isEmpty && usersJourneys().isEmpty {
            DispatchQueue.main.async {
                self.view.addSubview(self.emptyView)
            }
        } else {
            DispatchQueue.main.async {
                self.emptyView.removeFromSuperview()
            }
            totalJourneys.formUnion(usersFollowedJourneys())
            totalJourneys.formUnion(usersJourneys())
        }
    }
    
    fileprivate func usersJourneys() -> Set<Journey> {
        var currentJourney = Set<Journey>()
        guard let journeyIds = appUser?._journeys else {
            return currentJourney
        }
        for journey in journeyIds {
            DynamoDBManager.shared.loadJourney(journeyId: journey, completion: { (journey, error) in
                guard let journey = journey else {return}
                currentJourney.insert(journey)
            })
        }
        return currentJourney
    }
    
    fileprivate func usersFollowedJourneys() -> Set<Journey> {
        var currentJourney = Set<Journey>()
        guard let followedJourneyIds = appUser?._journeysFollowed else {
            return currentJourney
        }
        for journey in followedJourneyIds {
            DynamoDBManager.shared.loadJourney(journeyId: journey, completion: { (journey, error) in
                guard let journey = journey else {return}
                currentJourney.insert(journey)
            })
        }
        return currentJourney
    }
    
    
    deinit {
        tableView?.dg_removePullToRefresh()
        print("deinit")
    }
}
extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return appEvents.count + 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.item == appEvents.count { // add paging
            let cell = tableView.dequeueReusableCell(withIdentifier: "loading", for: indexPath)
            cell.addSubview(loading)
            loading.snp.makeConstraints({ (make) in
                make.centerX.equalTo(self.view.snp.centerX)
                make.centerY.equalTo(cell.contentView.snp.centerY)
            })
            loading.startAnimating()
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeFeedCell", for: indexPath) as! HomeFeedTableViewCell ///Change name
            let event = Array(appEvents)[indexPath.row]
            cell.configureCell(event: event)
            cell.layer.cornerRadius = 8
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == appEvents.count {
            return 100
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row != appEvents.count else {return}
        let cell = tableView.cellForRow(at: indexPath) as! HomeFeedTableViewCell
        guard let journey = cell.journey else {return}
        navigationController?.pushViewController(JourneyDetailViewController(journey: journey), animated: true)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == events.count{
            
        }
    }
}

extension HomeViewController: PresentVCDelgate {
    func updateTableView() {
        self.tableView?.setNeedsDisplay()
    }
    
    func mentionsTapped() {
        self.navigationController?.pushViewController(ProfileViewController.instantiate(withStoryboard: "Main"), animated: true)
    }
    
    func hashTagTapped() {
        self.navigationController?.pushViewController(DiscoveryViewController.instantiate(withStoryboard: "Discover"), animated: true)
    }
}

/////Delete when AWS is set up
//        let content = contents[indexPath.row]
//        cell.set(image: contents[indexPath.row])
//        switchItUp(image: content, cell: cell)

//private func switchItUp(image: UIImage, cell: HomeFeedCollectionViewCell) {
//    switch image {
//    case #imageLiteral(resourceName: "a11"):
//        cell.postLabel.text = "Saber Lily"
//        cell.likeLabel.text = "420"
//    case #imageLiteral(resourceName: "nostalgic1"):
//        cell.postLabel.text = "Finally finished the city of Elianor"
//        cell.likeLabel.text = 5.description
//    case #imageLiteral(resourceName: "nostalgic2"):
//        cell.postLabel.text = "Sunset overview with a bridge inbetween"
//        cell.likeLabel.text = 18.description
//    case #imageLiteral(resourceName: "nostalgic3"):
//        cell.postLabel.text = "Something that just came to mind"
//        cell.likeLabel.text = 48.description
//    case #imageLiteral(resourceName: "nostalgic4"):
//        cell.postLabel.text = "Dreamt of this, thought it would be perfect for my first art piece"
//        cell.likeLabel.text = 150.description
//    default:
//        break
//    }
//}

