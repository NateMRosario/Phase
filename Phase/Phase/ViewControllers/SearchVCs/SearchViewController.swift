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

    @IBAction func dismiss(_ sender: UIBarButtonItem) {
        self.dismiss(animated: false, completion: nil)
    }
    
    let searchBar = UISearchBar()
    var pageMenu : CAPSPageMenu?
    var controllerArray : [UIViewController] = []
    
    let controller4: TestTableViewController = TestTableViewController(nibName: "TestTableViewController", bundle: nil)
    let controller2: TestCollectionViewController = TestCollectionViewController(nibName: "TestCollectionViewController", bundle: nil)
    let controller3: TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
    let controller1: TestViewController = TestViewController(nibName: "TestViewController", bundle: nil)
    
    let parameters: [CAPSPageMenuOption] = [
        .scrollMenuBackgroundColor(.white),
        .viewBackgroundColor(.white),
        .selectionIndicatorColor(ColorPalette.appBlue),
        .selectionIndicatorHeight(5),
        .selectedMenuItemLabelColor(UIColor(red: 30.0/255.0, green: 30.0/255.0, blue: 30.0/255.0, alpha: 1.0)),
        .bottomMenuHairlineColor(UIColor(red: 70.0/255.0, green: 70.0/255.0, blue: 80.0/255.0, alpha: 1.0)),
        .menuItemFont(UIFont.boldSystemFont(ofSize: 17)),
        .menuHeight(40.0),
        .menuItemWidth(90.0),
        .useMenuLikeSegmentedControl(true),
//        .centerMenuItems(false),
        .menuItemSeparatorPercentageHeight(0.0)
    ]
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        pageMenu = CAPSPageMenu(viewControllers: controllerArray,
                                frame: view.safeAreaLayoutGuide.layoutFrame,
                                pageMenuOptions: parameters)
        self.addChildViewController(pageMenu!)
        self.view.addSubview(pageMenu!.view)
        
        pageMenu!.didMove(toParentViewController: self)
    }
    
    override func shouldAutomaticallyForwardRotationMethods() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNav()
        
        controller1.title = "Top"
        controller1.delegate = self
        controllerArray.append(controller1)
        
        controller2.title = "Tags"
        controllerArray.append(controller2)
        
        controller3.title = "Journeys"
        controllerArray.append(controller3)
        
        controller4.title = "People"
        controllerArray.append(controller4)

//        pageMenu = CAPSPageMenu(viewControllers: controllerArray,
//                                frame: CGRect(x: 0, y: ((navigationController?.navigationBar.frame.height)! + 34),
//                                              width: self.view.bounds.width,
//                                              height: view.safeAreaLayoutGuide.layoutFrame.height),

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
