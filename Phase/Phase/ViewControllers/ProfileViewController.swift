//
//  ProfileViewController.swift
//  Phase
//
//  Created by C4Q on 3/13/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit
import Material
import BetterSegmentedControl

class ProfileViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var segmentedViewTop: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var atDisplayNameLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var profileView: UIView!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var segmentedView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var editProfileButton: UIButton! {
        didSet {
        editProfileButton.tintColor = UIColor.gray
        }
    }
    @IBOutlet weak var constraintHeightHeaderImages: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.estimatedRowHeight = 100 //experimental
        }
    }
    @IBOutlet weak var bioLabel: UILabel!
    @IBAction func segmentedControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedSegment = 0
        case 1:
            selectedSegment = 1
        case 2:
            selectedSegment = 2
        default:
            break
        }
    }
    
    @IBAction func editProfileButtonPressed(_ sender: UIButton) {
        //TODO: Present settingsVC
    }
    
    // At this offset the Header stops its transformations
    private let headerStopOffset:CGFloat = 200 - 64
    private let hiddenLabelDistanceToTop:CGFloat = 30.0
    private var selectedSegment = 0 {
        didSet {
            tableView.reloadData()
        }
    }

    private var about = ["Account", "Your Hypes","Posts You've Hypped", "Your Posts", "Your Comments", "History", "Blocked Users", "Flagged Posts"]
    
    lazy var headerBlurImageView: UIImageView = {
        let biv = UIImageView()
        biv.alpha = 0.0
        biv.contentMode = .scaleAspectFill
        biv.image = #imageLiteral(resourceName: "Manhattan").blur(radius: 10, tintColor: UIColor.clear, saturationDeltaFactor: 1)
        return biv
    }()
    
    lazy var headerImageView: UIImageView = {
        let hiv = UIImageView()
        hiv.image = #imageLiteral(resourceName: "Manhattan")
        hiv.contentMode = .scaleAspectFill
        return hiv
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        bioLabel.text = "An Asian boy living in new york city An Asian boy living in new york cityAn Asian boy living in new york cityAn Asian boy living in new york cityAn Asian boy living in new york cityAn Asian boy living in new york cityAn Asian boy living in new york cityAn Asian boy living in new york city"
        let size = profileView.systemLayoutSizeFitting(UILayoutFittingCompressedSize)
        profileView.frame.size = size
        tableView.tableHeaderView = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = segmentedView
        
        setupUI()
        loadData()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = UIEdgeInsetsMake(headerView.frame.height, 0, 0, 0)
        
        //setupSettingsButton()
        
//        handleLabel.text = currentUser!.displayName
//        atDisplayNameLabel.text = "@" + currentUser!.displayName!
//        hiddenLabel.text = "@" + currentUser!.displayName!
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadData()
    }
    
    private func loadData() {
    
    }
    
    private func setupUI() {
        
        // Header - Profile image
        profileImage.layer.borderWidth = 4
        profileImage.borderColor = .white
        profileImage.layer.cornerRadius = profileImage.bounds.height/2
        profileImage.clipsToBounds = true
        
        // Header - Edit profile button
        editProfileButton.layer.borderColor = UIColor.gray.cgColor
        editProfileButton.layer.borderWidth = 1
        editProfileButton.layer.cornerRadius = 14

 
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
    
    public static func storyboardInstance() -> ProfileViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        return profileViewController
    }
    
    @objc func controlValueChanged(_ sender: BetterSegmentedControl) {
        switch sender.index {
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

//MARK: - TABLEVIEW METHODS
extension ProfileViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let v = UIView()
        v.heightPreset = .large
        let control = BetterSegmentedControl(
            frame: CGRect(x: 0.0, y: -1, width: view.bounds.width, height: 44.0),
            titles: ["One", "Two", "Three"],
            index: 0,
            options: [.backgroundColor(UIColor(displayP3Red: 245/255, green: 245/255, blue: 245/255, alpha: 1)),
                      .titleColor(.gray),
                      .indicatorViewBackgroundColor(UIColor.lightGray),
                      .selectedTitleColor(.white),
                      .cornerRadius(4),
                      .titleFont(UIFont(name: "HelveticaNeue-Medium", size: 20.0)!),
                      .selectedTitleFont(UIFont(name: "HelveticaNeue-Medium", size: 20.0)!)]
        )
        control.addTarget(self, action: #selector(controlValueChanged(_:)), for: .valueChanged)
        view.addSubview(control)
        v.addSubview(control)
        return v
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 50
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        // UIScreen.main.bounds.width * 0.5628 + 32 //for testing purposes
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath)
        cell.textLabel?.text = "1"
            return cell
      //  }
    }
}

// MARK: - SCROLLING INTERACTIONS
// Basically all the fancy stuff goes on here
extension ProfileViewController: UIScrollViewDelegate {
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
            headerBlurImageView.alpha = min(1.0, (offset - alignToNameLabel)/hiddenLabelDistanceToTop)
            
            // PROFILE IMAGE
            // Slow down the animation
            let profileImageScaleFactor = (min(headerStopOffset, offset)) / profileImage.bounds.height / 2.7
            let profileImageSizeVariation = ((profileImage.bounds.height * (1.0 + profileImageScaleFactor)) - profileImage.bounds.height) / 2
            
            profileImageTransform = CATransform3DTranslate(profileImageTransform, 0, profileImageSizeVariation, 0)
            profileImageTransform = CATransform3DScale(profileImageTransform, 1.0 - profileImageScaleFactor, 1.0 - profileImageScaleFactor, 0)
            
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
        
//        // MARK: - Segmented control offset *Maybe put as section header?, not sure if it works with multiple sections*
//        // Segment control
//        let segmentViewOffset = profileView.bounds.height - segmentedView.bounds.height - offset
//        var segmentTransform = CATransform3DIdentity
//
//        // Scroll the segment view until its offset reaches the same offset at which the header stopped shrinking
//        segmentTransform = CATransform3DTranslate(segmentTransform, 0, max(segmentViewOffset, -headerStopOffset), 0)
//        segmentedView.layer.transform = segmentTransform
//
//        // Set scroll view insets just underneath the segment control
//        tableView.scrollIndicatorInsets = UIEdgeInsetsMake(segmentedView.bounds.maxY, 0, 0, 0)
    }
}
