//
//  ProfileViewController.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 04/04/25.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private var user: User? {
        didSet {
            updateUI()
        }
    }
    
    @IBOutlet private weak var nameView: UIView!
    @IBOutlet private weak var emailView: UIView!
    @IBOutlet private weak var phoneView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var phoneLabel: UILabel!
    @IBOutlet private weak var editButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadUserData()
        
        // Add logout button to navigation bar
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "rectangle.portrait.and.arrow.right"),
            style: .plain,
            target: self,
            action: #selector(handleLogoff)
        )
        
        title = "Profile"
    }
    
    private func setupUI() {
        [nameView, emailView, phoneView].forEach { view in
            view?.layer.cornerRadius = 8
            view?.clipsToBounds = true
        }
        
        editButton.layer.cornerRadius = 8
    }
    
    private func loadUserData() {
        if let savedUser = User.load() {
            user = savedUser
        } else {
            user = User(name: "User Name",
                       email: "user@example.com",
                       phone: "(00) 00000-0000",
                       bio: "Tell us about yourself...")
            User.save(user!)
        }
    }
    
    private func updateUI() {
        guard let user = user else { return }
        nameLabel.text = user.name
        emailLabel.text = user.email
        phoneLabel.text = user.phone
    }
    
    @objc func handleLogoff(_ sender: Any) {
        StoreManager.shared.remove(forKey: "logged")
        
        // Present login screen
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "BYZ-38-t0r")
            window.rootViewController = loginVC
            window.makeKeyAndVisible()
        }
    }
    
    @IBAction func handleEdit(_ sender: Any) {
        let editVC = EditProfileViewController()
        editVC.user = user
        editVC.delegate = self
        editVC.modalPresentationStyle = .formSheet
        present(editVC, animated: true)
    }
}

extension ProfileViewController: EditProfileViewControllerDelegate {
    func didUpdateUser(_ user: User) {
        self.user = user
        User.save(user)
    }
}
