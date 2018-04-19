//
//  SearchViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import Parchment
import SnapKit

class SearchViewController: UIViewController {

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    let searchBar = UISearchBar()
    
    let controller4: TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
    let controller2: PeopleViewController = PeopleViewController.instantiate(withStoryboard: "SearchVCs")
    let controller3: TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
    let controller1: PeopleViewController = PeopleViewController.instantiate(withStoryboard: "SearchVCs")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        
        controller1.title = "Top"
        controller2.title = "Tags"
        controller3.title = "Journeys"
        controller4.title = "People"
        
        let pagingViewController = FixedPagingViewController(viewControllers: [
            controller1,
            controller2,
            controller3,
            controller4
            ])
        
        pagingViewController.borderOptions = PagingBorderOptions.visible(height: 1, zIndex: Int.max - 1, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        pagingViewController.indicatorOptions = PagingIndicatorOptions.visible(height: 5, zIndex: Int.max - 1, spacing: UIEdgeInsets.zero, insets: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        pagingViewController.menuHorizontalAlignment = .center
        pagingViewController.menuItemSize = PagingMenuItemSize.sizeToFit(minWidth: 50, height: 40)
        pagingViewController.menuInteraction = .none
            
        addChildViewController(pagingViewController)
        view.addSubview(pagingViewController.view)
        pagingViewController.view.snp.makeConstraints { (make) in
            make.edges.equalTo(view.safeAreaLayoutGuide.snp.edges)
        }
        pagingViewController.didMove(toParentViewController: self)
        
    }
    
    func configureNav() {
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
        searchBar.placeholder = "Search"
        searchBar.textField?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        searchBar.textField?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        searchBar.textField?.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder ?? "", attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.textField?.textColor = .gray
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        navigationController?.navigationBar.topItem?.titleView = searchBar
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
    }
}

extension SearchViewController: ResignKeyboardDelegate {
    func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
}
