//
//  JourneyCarouselCollapsedViewController.swift
//  Phase
//
//  Created by Clint Mejia on 3/29/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

class JourneyCarouselCollapsedViewController: UIViewController {
    
    // MARK: - Properties
    private let commentView = JourneyCommentTableView()
    
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
        self.view.backgroundColor = UIColor.red
        self.commentView.journeyCommentTableView.delegate = self
        self.commentView.journeyCommentTableView.dataSource = self
        setupView()
    }
    
    // MARK: - Functions
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setupView() {
        setViewConstraints()
    }
    
    private func getPost() {}
    
    
    // MARK: - Contraints
    private func setViewConstraints() {
        self.view.addSubview(commentView)
        commentView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.snp.edges)
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
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! JourneyCommentTableViewCell
        
        return cell
    }
}
