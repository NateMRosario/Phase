//
//  FollowsCollectionViewCell.swift
//  Phase
//
//  Created by C4Q on 3/22/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class FollowsCollectionViewCell: UICollectionViewCell {
    var names = [String]() {
        didSet {
            tableView.reloadData()
        }
    }
    var images: [UIImage]?
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(FollowingTableCell.self, forCellReuseIdentifier: "CollectionCell")
        tv.dataSource = self
        return tv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    private func commonInit() {
        backgroundColor = .blue
        setupViews()
    }
    private func setupViews() {
        addSubview(tableView)
        tableView.snp.makeConstraints { (view) in
            view.top.equalTo(self)
            view.leading.trailing.bottom.equalTo(self)
        }
    }
    
    public func configureCell(names: [String], images: [UIImage]) {
        self.names = names
        self.images = images
    }
}
extension FollowsCollectionViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionCell", for: indexPath)
        cell.textLabel?.text = names[indexPath.row]
        return cell
    }
}
