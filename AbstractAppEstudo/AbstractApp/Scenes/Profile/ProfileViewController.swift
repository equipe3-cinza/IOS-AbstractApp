//
//  ProfileViewController.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 04/04/25.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func handleLogoff(_ sender: Any) {
        StoreManager.shared.remove(forKey: "logged")
        self.dismiss(animated: true)
    }
}
