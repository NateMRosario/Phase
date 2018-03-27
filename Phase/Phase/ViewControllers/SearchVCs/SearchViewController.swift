//
//  SearchViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit
import PageMenu
import SnapKit

class SearchViewController: UIViewController {

    var pageMenu : CAPSPageMenu?
    let searchBar = UISearchBar()
    var controllerArray : [UIViewController] = []

    var controller: UIViewController = TopViewController.instantiate(withStoryboard: "SearchVCs")
    var journeyVC = JourneyViewController.instantiate(withStoryboard: "SearchVCs")
    var peopleVC = PeopleViewController.instantiate(withStoryboard: "SearchVCs")

    var parameters: [CAPSPageMenuOption] = [
        .menuItemSeparatorWidth(4.3),
        .useMenuLikeSegmentedControl(true),
        .menuItemSeparatorPercentageHeight(0.1),
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNav()
        
        controller.title = "Top"
        journeyVC.title = "Journey"
        peopleVC.title = "People"
        
        controllerArray.append(controller)
        controllerArray.append(journeyVC)
        controllerArray.append(peopleVC)
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray,
                                frame: CGRect(x: 0, y: ((navigationController?.navigationBar.frame.height)! + 34),
                                              width: self.view.bounds.width,
                                              height: view.safeAreaLayoutGuide.layoutFrame.height),
                                pageMenuOptions: parameters)
        
        self.view.addSubview(pageMenu!.view)
    }
    
    func configureNav() {
        
        navigationController?.navigationBar.backItem?.backBarButtonItem?.title = ""
        navigationItem.backButton.title = ""
        navigationController?.navigationBar.disableShadow()
        
        searchBar.textField?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        searchBar.textField?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        searchBar.textField?.attributedPlaceholder = NSAttributedString(string: searchBar.placeholder ?? "", attributes: [.foregroundColor: UIColor.lightGray])
        searchBar.textField?.textColor = .gray
        searchBar.textField?.isEnabled = false
        searchBar.showsCancelButton = true
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        
        navigationController?.navigationBar.topItem?.titleView = searchBar
    }
    
    @objc func back() {
        self.dismiss(animated: false, completion: nil)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.dismiss(animated: false, completion: nil)
    }
}
