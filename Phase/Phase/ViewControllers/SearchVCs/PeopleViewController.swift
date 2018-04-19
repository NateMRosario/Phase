//
//  PeopleViewController.swift
//  Phase
//
//  Created by C4Q on 3/22/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class PeopleViewController: UIViewController {
    
    var people = [AppUser]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAppUsers()
        tableView.dataSource = self
        tableView.delegate = self
        self.navigationController?.hidesBarsOnSwipe = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func getAppUsers() {
        DynamoDBManager.shared.scanUsers { (users, error) in
            if let error = error {
                print(error)
            } else if let users = users {
                self.people = users
            }
            
        }
    }
}

extension PeopleViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        cell.textLabel?.text = "yo"
        return cell
    }
}
extension PeopleViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
