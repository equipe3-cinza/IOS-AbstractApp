//
//  SceneDelegate.swift
//  AbstractApp
//
//  Created by Silvano Maneck Malfatti on 21/03/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        let isLoggedIn = StoreManager.shared.get(forKey: "logged") == "true"
        
        if isLoggedIn {
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
            window?.rootViewController = tabBarController
        } else {
            // Show login screen
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let loginVC = storyboard.instantiateInitialViewController() {
                window?.rootViewController = loginVC
            }
        }
        
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
        print("Cena ja foi destruida")
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        print("Cena está ativa")
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
        print("Cena que irá perder o foco em breve")
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        print("Cena podera irá ganhar o foco em breve")
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
        print("Cena está em background")
    }
}

