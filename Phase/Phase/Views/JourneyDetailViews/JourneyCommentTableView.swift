//JourneyCommentTableView.swift
//  JourneyCommentTableView.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol JourneyCommentTableViewDelegate: class {
    func refreshTableView()
}

class JourneyCommentTableView: UIView {
    
    // MARK: - TableViewCell Identifier
    let cellID = "JourneyCommentTableViewCell"
    
    // MARK: - Lazy variables
    lazy var journeyCommentTableView: UITableView = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        let tableView = UITableView()
        tableView.register(JourneyCommentTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.refreshControl = refreshControl
        return tableView
    }()
    
    // MARK: - Delegate
    weak var delegate: JourneyCommentTableViewDelegate?
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    // MARK: - Functions
    private func commonInit() {
        backgroundColor = UIColor.orange
        setupViews()
    }
    
    private func setupViews() {
        setupJourneyCommentTableViewConstraints()
    }
    
    @objc private func refreshTableView() {
        print("refreshTableView")
        delegate?.refreshTableView()
    }
    
    // MARK: - Constraints
    private func setupJourneyCommentTableViewConstraints() {
        addSubview(journeyCommentTableView)
        journeyCommentTableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
}








