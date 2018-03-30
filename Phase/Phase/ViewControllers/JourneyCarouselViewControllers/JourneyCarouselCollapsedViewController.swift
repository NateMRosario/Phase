//
//  JourneyCarouselCollapsedViewController.swift
//  Phase
//
//  Created by Clint Mejia on 3/29/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

extension NSMutableAttributedString {
    @discardableResult func bold(_ text: String) -> NSMutableAttributedString {
        let attrs: [NSAttributedStringKey: Any] = [.font: UIFont(name: "AvenirNext-Medium", size: 12)!]
        let boldString = NSMutableAttributedString(string:text, attributes: attrs)
        append(boldString)
        
        return self
    }
    
    @discardableResult func normal(_ text: String) -> NSMutableAttributedString {
        let normal = NSAttributedString(string: text)
        append(normal)
        
        return self
    }
}

class EventDummyDate {
    var _userId: String
    var _eventId: String
    var _caption: String
    var _media: String
    
    init(userId: String, creationDate: String, caption: String, media: String) {
        self._userId = userId
        self._eventId = creationDate
        self._caption = caption
        self._media = media
    }
}

class JourneyCarouselCollapsedViewController: UIViewController {
    
    // MARK: - Properties
    let commentView = JourneyEventDetailView()
    private var comments = [EventDummyDate]() {
        didSet {
            DispatchQueue.main.async {
                self.commentView.journeyCommentTableView.reloadData()
            }
        }
    }
    
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
    
    
    // MARK: - Life cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clear
        self.commentView.journeyCommentTableView.delegate = self
        self.commentView.journeyCommentTableView.dataSource = self
        setupView()
        dummmyData()
    }
    
    // MARK: - Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func dummmyData() {
        let event0 = EventDummyDate(userId: "Nate", creationDate: "2h", caption: "Cool stuff, bruh! 21! 21! 21! 21!", media: "man4.jpg")
        let event1 = EventDummyDate(userId: "Clint", creationDate: "1h 39m", caption: "Prayer hands", media: "man5.jpg")
        let event2 = EventDummyDate(userId: "Ka$hMoney", creationDate: "1h 30m", caption: "Premium, yo! $$$$ Yields!", media: "man1.jpg")
        let event3 = EventDummyDate(userId: "Reiaz", creationDate: "30m", caption: "You're making the coach cry", media: "man2.jpg")
        
        comments.append(event0)
        comments.append(event1)
        comments.append(event2)
        comments.append(event3)
    
    }
    
    private func setupView() {
        setViewConstraints()
    }
    
    private func getPost() {}
    
    public func viewIsHidden(_ state: Bool) {
        guard state == true else {
            commentView.journeyCommentTableView.isHidden = false
            commentView.commentTextField.isHidden = false
            commentView.commentProfileImageView.isHidden = false
            return
        }
        commentView.journeyCommentTableView.isHidden = true
        commentView.commentTextField.isHidden = true
        commentView.commentProfileImageView.isHidden = true
        return
    }
    
    // MARK: - Contraints
    private func setViewConstraints() {
        self.view.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.width.equalTo(self.view.snp.width) //.multipliedBy(0.9)
            make.centerX.equalTo(self.view.snp.centerX)
            make.height.equalTo(self.view.snp.height)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }
    
}


// MARK: - UITableViewDelegate
extension JourneyCarouselCollapsedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
}

// MARK: - UITableViewDataSource
extension JourneyCarouselCollapsedViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JourneyCommentTableViewCell
        cell.configureCell(with: comments[indexPath.row])
        return cell
    }
}
