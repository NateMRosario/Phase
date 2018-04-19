//
//  EditProfileViewController.swift
//  Phase
//
//  Created by Reiaz Gafar on 3/14/18.
//  Copyright © 2018 Reiaz Gafar. All rights reserved.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBAction func changeHeaderImage(_ sender: UIButton) {
    }
    @IBOutlet weak var profileImage: UIImageView!
    @IBAction func changeProfileImage(_ sender: UIButton) {
    }
        
    @IBAction func logoutButton(_ sender: UIButton) {
        //logout
    }
    
    @IBAction func dismissButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
