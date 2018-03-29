//
//  JourneyCommentTableView.swift
//  Phase
//
//  Created by Clint Mejia on 3/26/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import SnapKit

// MARK: - Custom Delegate
protocol JourneyCommentDelegate: class {
    func replyButtonTapped()
}

class JourneyCommentTableView: UIView {
    
    // MARK: - Views
    let headerViewID = JourneyHeaderView()
    let footerViewId = JourneyAddCommentVIew()
    
    // MARK: - TableViewCell Identifier
    let cellID = "JourneyCommentTableViewCell"
    
    // MARK: - Delegate
    weak var delegate: JourneyCommentDelegate?
    
    // MARK: - Lazy variables
    lazy var journeyCommentTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(JourneyCommentTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.backgroundColor = .yellow
        return tableView
    }()
    
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
        setupHeaderViewConstraints()
        setupJourneyCommentTableViewConstraints()
        setupFooterViewConstraints()
    }
    
    @objc private func replyButtonTapped() {
        print("reply button delegate")
        delegate?.replyButtonTapped()
    }
    
    // MARK: - Constraints
    private func setupHeaderViewConstraints() {
        addSubview(headerViewID)
        headerViewID.snp.makeConstraints { (make) in
            make.top.equalTo(self)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.15)
        }
    }
    
    private func setupJourneyCommentTableViewConstraints() {
        addSubview(journeyCommentTableView)
        journeyCommentTableView.snp.makeConstraints { (make) in
            make.top.equalTo(headerViewID.snp.bottom)
            make.width.equalTo(self)
            make.centerX.equalTo(self)
            make.height.equalTo(self).multipliedBy(0.70)
        }
    }
    
    private func setupFooterViewConstraints() {
        addSubview(footerViewId)
        footerViewId.snp.makeConstraints { (make) in
            make.bottom.equalTo(self)
            make.centerX.equalTo(self)
            make.width.equalTo(self)
            make.top.equalTo(journeyCommentTableView.snp.bottom)
        }
    }
    
}
