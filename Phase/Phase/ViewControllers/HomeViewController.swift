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
                self.homeCollectionView.reloadData()
            }
        }
    }
    var appEvents = [String : [Event]]() {
        didSet {
            print("AppEvent: \(appEvents)")
            DispatchQueue.main.async {
                self.homeCollectionView.reloadData()
            }
        }
    }
    
    var eventIDs = [String]() {
        didSet {
            for id in eventIDs {
                print(id)
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
        self.homeCollectionView.alwaysBounceVertical = true
        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
        homeCollectionView.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
            //DO THINGS
            self?.homeCollectionView.dg_stopLoading()
            }, loadingView: loadingView)
        let img = #imageLiteral(resourceName: "085 October Silence").crop(toWidth: UIScreen.main.bounds.width, toHeight: UIScreen.main.bounds.width)!
        homeCollectionView.dg_setPullToRefreshFillColor(UIColor(patternImage: img))
        homeCollectionView.dg_setPullToRefreshBackgroundColor(homeCollectionView.backgroundColor!)
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
        homeCollectionView?.dg_removePullToRefresh()
        print("deinit")
    }
}
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return journeysFollowed.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == journeysFollowed.count{
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
        let journey = journeysFollowed[indexPath.row]
        let event = appEvents[journey._journeyId!]?.last
        guard let user = appUser else {return cell}
        
        let event1: Event = Event()
        
        cell.configureCell(journey: journey, user: user)
        //        let content = contents[indexPath.row]
        //        cell.set(image: contents[indexPath.row])
        //        switchItUp(image: content, cell: cell)
        cell.layer.cornerRadius = 8
        return cell
    }
    ///Delete when AWS is set up
    private func switchItUp(image: UIImage, cell: HomeFeedCollectionViewCell) {
        switch image {
        case #imageLiteral(resourceName: "a11"):
            cell.postLabel.text = "Saber Lily"
            cell.likeLabel.text = "420"
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
}
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        navigationController?.pushViewController(JourneyCarouselViewController(), animated: true)
    }
    //TODO:
}

extension HomeViewController: CollectionViewDelegateLayout {
    private func numberOfColumns() -> Int {
        return 1
    }
    
    internal func sizeForItemAt(indexPath: IndexPath) -> CGSize {
        if indexPath.item == journeysFollowed.count{
            return CGSize(width: configure.itemWidth,height: 100)
        }
        let image = #imageLiteral(resourceName: "nostalgic4")
        let width = configure.itemWidth
        var height = width / image.size.width * image.size.height + 49
        if height < 300 {
            height = 400
        }
        return CGSize(width: width, height: height)
    }
}

extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        navigationController?.setToolbarHidden(true, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.item == journeysFollowed.count{
            // loadMoreData()
        }
    }
}


