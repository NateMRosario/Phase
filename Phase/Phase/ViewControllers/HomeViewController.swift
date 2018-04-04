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
    
    fileprivate var contents = [#imageLiteral(resourceName: "a11"), #imageLiteral(resourceName: "nostalgic1"), #imageLiteral(resourceName: "nostalgic2"), #imageLiteral(resourceName: "nostalgic3"), #imageLiteral(resourceName: "nostalgic4")]
    
    var appUser = AppUser() 
    var journeysFollowed = [Journey]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    var appEvents = [String : [Event]]() {
        didSet {
//            print("AppEvent: \(appEvents)")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var eventIDs = [String]() {
        didSet {
            for id in eventIDs {
//                print(id)
                DynamoDBManager.shared.loadEvent(eventId: id, completion: { (event, error) in ///FIX THIS ALMOST THERE!
                    if let error = error {
                        print(error)
                    }
                    guard let event = event else {print("event in eventIDs");return}
                    var currentEvents = [Event]()
                    if self.appEvents[event._journey!] == nil {
                        currentEvents.append(event)
                        self.appEvents[event._journey!] = currentEvents
                    } else {
                        currentEvents = self.appEvents[event._journey!]!
                        currentEvents.append(event)
                        self.appEvents[event._journey!] = currentEvents
                    }
                })
            }
//            self.fetchEvents()
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
            //DO THINGS
            self?.tableView.dg_stopLoading()
            }, loadingView: loadingView)
        let img = #imageLiteral(resourceName: "085 October Silence").crop(toWidth: UIScreen.main.bounds.width, toHeight: UIScreen.main.bounds.width)!
        tableView.dg_setPullToRefreshFillColor(UIColor(patternImage: img))
        tableView.dg_setPullToRefreshBackgroundColor(tableView.backgroundColor!)
        fetchCurrentUser()
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
//        var currentEventID = Set<String>() {
//            didSet {
//                    self.eventIDs = Array(currentEventID)
//            }
//        }
        
        var currentJourney = Set<Journey>() {
            didSet {
                self.journeysFollowed = currentJourney.sorted{$0._creationDate as! Double > $1._creationDate as! Double}
                for journey in currentJourney {
                    guard let eventID = journey._events else {print("eventID");return}
                    self.eventIDs = Array(eventID)
                }
            }
        }
        ///TODO: Switch to this when following is active
//        guard let journeyIds = appUser?._journeysFollowed else {return}
        
        guard let journeyIds = appUser?._journeys else {print("journeyIds");return}
        for journey in journeyIds {
            DynamoDBManager.shared.loadJourney(journeyId: journey, completion: { (journey, error) in
                guard let journey = journey else {return}
                currentJourney.insert(journey)
            })
        }
    }
    
    private func fetchEvents() {
        
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

//let cell = collectionView.dequeueReusableCell(with: HomeFeedCollectionViewCell.self, for: indexPath)
//let journey = journeysFollowed[indexPath.row]
//let event = appEvents[journey._journeyId!]?.last
//guard let user = appUser else {return cell}
//
//let event1: Event = Event()
//
//cell.configureCell(journey: journey, user: user)
////        let content = contents[indexPath.row]
////        cell.set(image: contents[indexPath.row])
////        switchItUp(image: content, cell: cell)
//cell.layer.cornerRadius = 8
//return cell
//}
/////Delete when AWS is set up
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
//}
//extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
//
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        navigationController?.pushViewController(JourneyCarouselViewController(), animated: true)
//    }
//    //TODO:
//}
//
//extension HomeViewController: CollectionViewDelegateLayout {
//    private func numberOfColumns() -> Int {
//        return 1
//    }
//
//    internal func sizeForItemAt(indexPath: IndexPath) -> CGSize {
//        if indexPath.item == journeysFollowed.count{
//            return CGSize(width: configure.itemWidth,height: 100)
//        }
//        let image = #imageLiteral(resourceName: "nostalgic4")
//        let width = configure.itemWidth
//        var height = width / image.size.width * image.size.height + 49
//        if height < 300 {
//            height = 400
//        }
//        return CGSize(width: width, height: height)

