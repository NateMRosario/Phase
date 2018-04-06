//
//  ProfileViewController.swift
//  Phase
//
//  Created by C4Q on 3/13/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//
import UIKit
import Material
import SnapKit
import Segmentio
import Kingfisher

class ProfileViewController: UIViewController, DynamoDBUserActionsDelegate {
    
    convenience init?(loadSelectedUser: String) {
        self.init()
        self.userInfoToDisplay = loadSelectedUser
    }
    @IBAction func editProfileImage(_ sender: UIButton) {
        //Edit profile Image
    }
    
    @IBAction func hitUpDMs(_ sender: UIButton) {
        
    }
    @IBOutlet weak var editProfileIndicator: UIImageView! {
        didSet {
            editProfileButton.layer.cornerRadius = editProfileIndicator.frame.height / 2
            editProfileIndicator.clipsToBounds = true
            
        }
    }
    
    @IBAction func goToUserSocialDetail(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            present(UINavigationController(rootViewController: FollowsViewController()), animated: true, completion: nil)
        case 1:
            present(UINavigationController(rootViewController: FollowsViewController()), animated: true, completion: nil)
        case 2:
            present(UINavigationController(rootViewController: FollowsViewController()), animated: true, completion: nil)
        case 3:
            present(UINavigationController(rootViewController: FollowsViewController()), animated: true, completion: nil)
        default:
            break
        }
    }
    
    @IBOutlet weak var followers: UILabel!
    @IBOutlet weak var watchers: UILabel!
    @IBOutlet weak var following: UILabel!
    @IBOutlet weak var watching: UILabel!
    @IBOutlet weak var segmentedViewTop: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var segmentedView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var hitUpDM: UIButton!
    @IBOutlet weak var constraintHeightHeaderImages: NSLayoutConstraint!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var editProfileButton: UIButton! {
        didSet {
            editProfileButton.tintColor = UIColor.gray
        }
    }
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 300
            tableView.estimatedRowHeight = UITableViewAutomaticDimension
            tableView.register(UINib.init(nibName: "JourneyTableViewCell", bundle: nil), forCellReuseIdentifier: "JourneyCell")
        }
    }
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        //TODO: Present settingsVC
    }
    
    // At this offset the Header stops its transformations
    private let headerStopOffset:CGFloat = 200 - 64
    private let hiddenLabelDistanceToTop:CGFloat = 30.0
    private var selectedSegment = selectedSegmentioIndex {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    @IBOutlet weak var followButton: UIButton! {
        didSet {
            followButton.layer.cornerRadius = followButton.bounds.height / 2
            followButton.clipsToBounds = true
        }
    }
    @IBAction func followButtonPressed(_ sender: UIButton) {
        guard let user = currentDisplayedUser else {followButton.isEnabled = false; return}
        switch followButton.currentTitle! {
        case "Follow":
            dynamoDBActions.followUser(user: user) { (error) in
                if let error = error {
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                } else {
                    self.followButton.titleLabel?.text = "Following"
                }
            }
        case "Unfollow":
            dynamoDBActions.unfollowUser(user: user) { (error) in
                if let error = error {
                    self.showAlert(title: "Error", message: "\(error.localizedDescription)")
                } else {
                    self.followButton.titleLabel?.text = "Follow"
                }
            }
        default:
            break
        }
    }
    
    // Sticky header and fake nav bar
    lazy var headerBlurImageView: UIImageView = {
        let biv = UIImageView()
        biv.alpha = 0.0
        biv.contentMode = .scaleAspectFill
        //        biv.backgroundColor = ColorPalette.appBlue
        biv.image = #imageLiteral(resourceName: "085 October Silence").blur(radius: 10, tintColor: UIColor.clear, saturationDeltaFactor: 1)
        return biv
    }()
    
    lazy var headerImageView: UIImageView = {
        let hiv = UIImageView()
        hiv.image = #imageLiteral(resourceName: "Manhattan")
        hiv.contentMode = .scaleAspectFill
        return hiv
    }()
    
    // Varriables to display user profile when selecting someone's profile
    private var currentDisplayedUser: AppUser? {
        didSet {
            setupUserInfo(with: currentDisplayedUser!)
        }
    }
    public var userInfoToDisplay = "" {
        didSet {
            if userInfoToDisplay != "" {
                print("this is the current user: \(userInfoToDisplay)")
                loadData(for: userInfoToDisplay)
            }
        }
    }
    
    public var isOwnProfile = true
    private var userJourneys = [Journey]() {
        didSet {
            print("user journeys set")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    let dynamoDBActions = DynamoDBManager.shared
    
    // MARK: - View life cycles
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        bioLabel.text = "I tried so hard and got so far, but in the end, it doesn't even maaatterrrrr"
        
        // This makes tableView header height dynamic
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupUserInfo(with: currentDisplayedUser!)
        userJourneys = []
        if isOwnProfile {
            loadData(for: CognitoManager.shared.userId)
        }
        let size = profileView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        profileView.frame.size = size
        tableView.tableHeaderView = profileView
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isOwnProfile {
            loadData(for: CognitoManager.shared.userId)
        }
        navigationController?.navigationBar.isHidden = true
        dynamoDBActions.delegate = self
        navigationController?.hidesBarsOnSwipe = true
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        setupUI()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
        tableView.separatorStyle = .none
        //setupSettingsButton()
        followButton.isHidden = true
        hitUpDM.isHidden = true
    }
    
    private func loadData(for user: String?) {
        if let user = user {
            DynamoDBManager.shared.loadUser(userId: user) { (appUser, error) in
                if let error = error {
                    self.showAlert(title: "Error", message: "Error displaying user profile, please try again. \(error.localizedDescription)")
                } else {
                    self.currentDisplayedUser = appUser
                }
            }
        }
    }
    
    private func setupUserInfo(with userInfo: AppUser) {
        loadJourneys(for: userInfo)
        DispatchQueue.main.async {
            self.username.text = userInfo._username
            self.followers.text = "\(userInfo._followerCount ?? 0)"
            self.watchers.text = "\(userInfo._watcherCount ?? 0)"
            self.following.text = "\(String(describing: userInfo._usersFollowed?.count ?? 0))"
            self.watching.text = "\(String(describing: userInfo._isWatching?.count ?? 0))"
            self.nameLabel.text = userInfo._fullName
            //self.bioLabel.text = userInfo._bio ?? "Hi my name is \(userInfo._fullName!)"
            self.headerLabel.text = userInfo._username
        }
        
        if let headerImageUrl = userInfo._headerImage {
            headerImageView.kf.setImage(with: URL(string: headerImageUrl)!)
        }
    }
    
    private func loadJourneys(for user: AppUser) {
        var loadedJourneys = [Journey]()
        if let journeys = user._journeys {
            for journey in journeys {
                dynamoDBActions.loadJourney(journeyId: journey) { (journey, error) in
                    if error != nil {
                        self.showAlert(title: "Error", message: "Failed to load user Journeys")
                    } else {
                        if !loadedJourneys.contains(journey!) {
                            loadedJourneys.append(journey!)
                        }
                    }
                }
            }
        }
        loadedJourneys = loadedJourneys.sorted(by: { (prev, next) -> Bool in
            (prev._creationDate as! Double) > (next._creationDate as! Double)
        })
        self.userJourneys = loadedJourneys
    }
    
    private func setupUI() {
        // Header - Profile image
        profileImage.layer.borderWidth = 4
        profileImage.borderColor = .white
        profileImage.layer.cornerRadius = profileImage.bounds.height/2
        profileImage.clipsToBounds = true
        
        headerView.clipsToBounds = true
        
        // Header - imageView
        headerView.insertSubview(headerImageView, belowSubview: headerLabel)
        headerImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.snp.leading)
            make.top.equalTo(headerView.snp.top)
            make.height.equalTo(headerView.snp.height)
            make.trailing.equalTo(view.snp.trailing)
        }
        // Header - blurImageView
        headerView.insertSubview(headerBlurImageView, belowSubview: headerLabel)
        headerBlurImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(self.view.snp.leading)
            make.top.equalTo(headerView.snp.top)
            make.height.equalTo(headerView.snp.height)
            make.trailing.equalTo(self.view.snp.trailing)
        }
    }
    
    // Not sure if I want the button
    private func setupSettingsButton() {
        let btn = UIButton(frame: CGRect(x: 4, y: 20, width: 44, height: 44))
        btn.setImage(#imageLiteral(resourceName: "Menu"), for: .normal)
        btn.tintColor = UIColor.white
        
        // ADDS BUTTON TO ALL VIEWS
        UIApplication.shared.keyWindow?.addSubview(btn)
        
        // LOCKS BUTTON TO HEADER (dissappears on scroll up)
        // headerView.insertSubview(btn, belowSubview: headerLabel)
    }
    
    // Selected segment for segmentio
    fileprivate func selectedSegmentioIndex() -> Int {
        return 0
    }
    
    fileprivate func selectedIndexChanged(to index: Int) {
        switch index {
        case 0:
            print(0)
        case 1:
            print(1)
        case 2:
            print(2)
        default:
            break
        }
    }
}

//MARK: - TABLEVIEW DATASOURCE
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            let v = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 40))
            let line = UIView(frame: CGRect(x: 0, y: 40, width: UIScreen.main.bounds.width, height: 1))
            line.backgroundColor = ColorPalette.whiteSmoke
            
            // SegmentedController in section header
            let segmentioView = Segmentio()
            SegmentioBuilder.buildSegmentioView(segmentioView: segmentioView, segmentioStyle: .onlyLabel)
            segmentioView.selectedSegmentioIndex = selectedSegmentioIndex()
            segmentioView.valueDidChange = { [weak self] _, segmentIndex in
                self?.selectedIndexChanged(to: segmentIndex)
            }
            v.addSubview(segmentioView)
            v.addSubview(line)
            segmentioView.snp.makeConstraints({ (make) in
                make.edges.equalTo(v.snp.edges)
            })
            return v
        }
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userJourneys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        // UIScreen.main.bounds.width * 0.5628 + 32 //for testing purposes
    }
    
    // MARK: - Cell for row at
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JourneyCell", for: indexPath) as! JourneyTableViewCell
        let journey = userJourneys[indexPath.row]
        cell.configureCell(with: journey, creator: currentDisplayedUser, row: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //let cell = tableView.cellForRow(at: indexPath) as! JourneyTableViewCell
        let journey = userJourneys[indexPath.row]
        let journeyDetailViewController = JourneyDetailViewController(journey: journey)
        //self.present(journeyDetailViewController, animated: true, completion: nil)
        navigationController?.pushViewController(journeyDetailViewController, animated: true)
    }
}

// MARK: - SCROLLING INTERACTIONS
// Basically all the fancy stuff goes on here
extension ProfileViewController: UIScrollViewDelegate, UITableViewDelegate {
    internal func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let offset = scrollView.contentOffset.y + headerView.bounds.height
        var profileImageTransform = CATransform3DIdentity
        var headerTransform = CATransform3DIdentity
        
        // PULL DOWN - Sticky Header
        if offset < 0 {
            let headerScaleFactor: CGFloat = -(offset) / headerView.bounds.height
            let headerSizevariation = ((headerView.bounds.height * (1.0 + headerScaleFactor)) - headerView.bounds.height)/2
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            // Hide views if scrolled super fast
            headerView.layer.zPosition = 0
            headerLabel.isHidden = true
        }
            // SCROLLING
        else {
            // HEADER CONTAINER
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-headerStopOffset, -offset), 0)
            
            // HIDDEN LABEL
            headerLabel.isHidden = false
            let alignToNameLabel = -offset + handleLabel.frame.origin.y + headerView.frame.height + headerStopOffset
            headerLabel.frame.origin = CGPoint(x: headerLabel.frame.origin.x, y: max(alignToNameLabel, hiddenLabelDistanceToTop + headerStopOffset))
            
            // BLUR
            headerBlurImageView.alpha = min(1.0, (offset - alignToNameLabel)/hiddenLabelDistanceToTop * 0.07)
            
            // PROFILE IMAGE
            // Slow down the animation
            let profileImageScaleFactor = (min(headerStopOffset, offset)) / profileImage.bounds.height / 2.7
            let profileImageSizeVariation = ((profileImage.bounds.height * (1.0 + profileImageScaleFactor)) - profileImage.bounds.height) / 2
            
            profileImageTransform = CATransform3DTranslate(profileImageTransform, 0, profileImageSizeVariation, 0)
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - profileImageScaleFactor, 1.0 - profileImageScaleFactor, 0)
            
            // Blur infront, reset tableView inset to fake nav height //64
            if headerBlurImageView.layer.zPosition < headerView.layer.zPosition {
                tableView.contentInset.top = headerView.frame.height -  headerStopOffset
            } else {
                tableView.contentInset.top = headerView.frame.height
            }
            
            if offset <= headerStopOffset {
                if profileImage.layer.zPosition < headerView.layer.zPosition {
                    headerView.layer.zPosition = 0
                }
            } else {
                if profileImage.layer.zPosition >= headerView.layer.zPosition {
                    headerView.layer.zPosition = 2
                }
            }
        }
        
        // Apply Transformations
        headerView.layer.transform = headerTransform
        profileImage.layer.transform = profileImageTransform
    }
}
