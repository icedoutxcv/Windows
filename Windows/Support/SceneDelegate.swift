//
//  SceneDelegate.swift
//  Windows
//
//  Created by xcv on 06/02/2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var firstTabNavigationController : UINavigationController!
    var secondTabNavigationControoller : UINavigationController!
    var thirdTabNavigationController : UINavigationController!

    var window: UIWindow?
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
    
        window = UIWindow(windowScene: scene as! UIWindowScene)
        window?.windowScene = windowScene
        
        let tabBarController = UITabBarController()
        tabBarController.tabBar.barTintColor = .black
        tabBarController.tabBar.tintColor = .yellow
        
        firstTabNavigationController = UINavigationController(rootViewController: FocusViewController())

        let firstItem = UITabBarItem(title: "Focus", image: UIImage(systemName: "timer"), tag: 0)

        firstTabNavigationController.tabBarItem = firstItem

        tabBarController.viewControllers = [firstTabNavigationController]

        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
    
}


