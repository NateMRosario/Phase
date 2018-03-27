//
//  JourneyCarouselViewController.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class JourneyCarouselViewController: UIViewController {
    
    // MARK: - Testbed properties
    var items: [Int] = []
    var post: [Int] = [1,2,3]
    
    var hideTopView = false
    var hideMiddleView = false
    var hideBottomView = false
    
    // MARK: - Properties
    private let journeyCarouselView = JourneyCarouselView()
    private let journeyHeaderView = JourneyHeaderView()
    private let journeyCommentView = JourneyCommentView()
    private let journeyAddCommentView = JourneyAddCommentVIew()
    
    private let cellID = "JourneyCommentTableViewCell"
    
    // MARK: - Init (Dependency injection)
    //    init(list: List){
    //        self.journey = post
    //        super.init(nibName: nil, bundle: nil)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    // MARK: - Lazy Variable
    lazy var journeyCommentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillProportionally
        stackView.alignment = .leading
        stackView.spacing = 8.0
        stackView.backgroundColor = UIColor.orange
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.cyan
        self.journeyCarouselView.carouselCollectionView.delegate = self
        self.journeyCarouselView.carouselCollectionView.dataSource = self
        self.journeyCommentView.journeyCommentTableView.delegate = self
        self.journeyCommentView.journeyCommentTableView.dataSource = self
        setupView()
    }
    
    // MARK: - Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        for i in 0 ... 99 {
            items.append(i)
            setupJourneyCarouselView()
            setupJourneyCommentStackView()
            //        setupJourneyCommentStackView()
            setJourneyCommentStackViewAttributes()
            setJourneyCommentStackViewZAxis()
        }
    }
    
    private func setJourneyCommentStackViewZAxis() {
        view.bringSubview(toFront: journeyCommentStackView)
    }
    
    private func setJourneyCommentStackViewAttributes() {
        //        journeyCommentStackView.addArrangedSubview(journeyHeaderView)
        journeyCommentStackView.addArrangedSubview(journeyCommentView)
        //        journeyCommentStackView.addArrangedSubview(journeyAddCommentView)
        journeyCommentStackView.translatesAutoresizingMaskIntoConstraints = false
        journeyCommentStackView.layer.borderWidth = 1
        journeyCommentStackView.layer.cornerRadius = 10
        journeyCommentStackView.layer.masksToBounds = true
        journeyCommentStackView.clipsToBounds = true
    }
    
    private func setViewsForStackView() {
    }
    
    
    
    //    a.backgroundColor = UIColor.red
    //    a.widthAnchor.constraint(equalToConstant: 200).isActive = true
    //    let aHeight = a.heightAnchor.constraint(equalToConstant: 120)
    //    aHeight.isActive = true
    //    aHeight.priority = 999
    //
    //    let bHeight = b.heightAnchor.constraint(equalToConstant: 120)
    //    bHeight.isActive = true
    //    bHeight.priority = 999
    //    b.backgroundColor = UIColor.green
    //    b.widthAnchor.constraint(equalToConstant: 200).isActive = true
    //
    //    view.addSubview(stackView)
    //    stackView.backgroundColor = UIColor.blue
    //    stackView.addArrangedSubview(a)
    //    stackView.addArrangedSubview(b)
    //    stackView.axis = .vertical
    //    stackView.distribution = .equalSpacing
    //    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    private func getPost() {}
    
    // MARK: - Contraints
    private func setupJourneyCarouselView() {
        self.view.addSubview(journeyCarouselView)
        journeyCarouselView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.leading.equalTo(self.view.snp.leading)
            make.trailing.equalTo(self.view.snp.trailing)
            make.height.equalTo(self.view.snp.height).multipliedBy(0.55
            )
        }
    }
    
    func setupJourneyCommentStackView() {
        self.view.addSubview(journeyCommentStackView)
        journeyCommentStackView.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.9)
            make.bottom.equalTo(view.snp.bottom).offset(-10)
            make.centerX.equalTo(view.snp.centerX)
            make.height.equalTo(view.snp.height).multipliedBy(0.45)
        }
    }
    
}

// MARK: - iCarouselDataSource
extension JourneyCarouselViewController: iCarouselDataSource {
    func numberOfItems(in carousel: iCarousel) -> Int {
        return 10
    }
    
    func carousel(_ carousel: iCarousel, viewForItemAt index: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        var itemView: UIImageView
        if let view = view as? UIImageView {
            itemView = view
            label = itemView.viewWithTag(1) as! UILabel
        } else {
            itemView = UIImageView(frame: CGRect(x: 0, y: 0, width: 385, height: 385))
            itemView.image = UIImage(named: "g")
            itemView.contentMode = .scaleAspectFit
            itemView.layer.masksToBounds = true
            itemView.clipsToBounds = true
            itemView.contentMode = .center
            
            label = UILabel(frame: itemView.bounds)
            label.backgroundColor = .clear
            label.textAlignment = .center
            label.font = label.font.withSize(50)
            label.tag = 1
            itemView.addSubview(label)
        }
        label.text = "\(items[index])"
        return itemView
    }
    
}

// MARK: - iCarouselDelegate
extension JourneyCarouselViewController: iCarouselDelegate {
    func carousel(_ carousel: iCarousel, valueFor option: iCarouselOption, withDefault value: CGFloat) -> CGFloat {
        if (option == .spacing) {
            return value * 1.1
        }
        return value
    }
    
}

// MARK: - UITableViewDelegate
extension JourneyCarouselViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource
extension JourneyCarouselViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JourneyCommentTableViewCell
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        cell.clipsToBounds = true
        
        return cell
    }
}

extension UIStackView {
    
    convenience init(axis:UILayoutConstraintAxis, spacing:CGFloat) {
        self.init()
        self.axis = axis
        self.spacing = spacing
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func anchorStackView(toView view:UIView, anchorX:NSLayoutXAxisAnchor, equalAnchorX:NSLayoutXAxisAnchor, anchorY:NSLayoutYAxisAnchor, equalAnchorY:NSLayoutYAxisAnchor) {
        view.addSubview(self)
        anchorX.constraint(equalTo: equalAnchorX).isActive = true
        anchorY.constraint(equalTo: equalAnchorY).isActive = true
        
    }
    
}
