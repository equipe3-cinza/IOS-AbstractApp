//
//  ViewController.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 21/03/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var paswordTextField: UITextField!
    @IBOutlet weak var switchLogin: UISwitch!
    @IBOutlet weak var button: UIButton!
    
    // Hardcoded credentials
    private let validEmail = "ufg"
    private let validPassword = "1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewController carrega e pronta para o uso")
        loginTextField.delegate = self
        paswordTextField.delegate = self
        button.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        switchLogin.isOn = StoreManager.shared.exists(forKey: "logged")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if switchLogin.isOn {
            navigateToMainApp()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        loginTextField.resignFirstResponder()
        paswordTextField.resignFirstResponder()
    }
    
    @IBAction func handleLogin(_ sender: UIButton) {
        guard let email = loginTextField.text,
              let password = paswordTextField.text,
              !email.isEmpty,
              !password.isEmpty else {
            showAlert(message: "Please enter email and password")
            return
        }
        
        if email == validEmail && password == validPassword {
            if switchLogin.isOn {
                StoreManager.shared.save("true", forKey: "logged")
            }
            navigateToMainApp()
        } else {
            showAlert(message: "Invalid credentials")
        }
    }
    
    @IBAction func handleSwitch(_ sender: Any) {
        if (!switchLogin.isOn) {
            StoreManager.shared.remove(forKey: "logged")
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    private func navigateToMainApp() {
        if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
           let window = sceneDelegate.window {
            
            // Create Timeline tab
            let timelineVC = TimelineViewController()
            let timelineNav = UINavigationController(rootViewController: timelineVC)
            timelineNav.tabBarItem = UITabBarItem(title: "Timeline", image: UIImage(systemName: "list.bullet"), tag: 0)
            
            // Create Profile tab
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let profileVC = storyboard.instantiateViewController(withIdentifier: "profile") as! ProfileViewController
            let profileNav = UINavigationController(rootViewController: profileVC)
            profileNav.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
            
            // Create Tab Bar Controller
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [timelineNav, profileNav]
            
            // Set as root and animate transition
            window.rootViewController = tabBarController
            UIView.transition(with: window,
                            duration: 0.3,
                            options: .transitionCrossDissolve,
                            animations: nil,
                            completion: nil)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = -140
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        loginTextField.resignFirstResponder()
        paswordTextField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if textField == paswordTextField {
            // Monta o texto atualizado simulando a digitação em tempo real
            if let currentText = textField.text as NSString? {
                let updatedText = currentText.replacingCharacters(in: range, with: string)
                button.isEnabled = updatedText.count >= 4
            }
        }
        
        return true
    }
}
