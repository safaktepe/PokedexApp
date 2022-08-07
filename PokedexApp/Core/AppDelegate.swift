//
//  AppDelegate.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 5.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow()
        UINavigationBar.appearance().largeTitleTextAttributes   = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().titleTextAttributes        = [NSAttributedString.Key.foregroundColor: UIColor.systemPink]
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
//        window?.rootViewController = initialViewController
        window?.rootViewController = createTabBarController()

        window?.makeKeyAndVisible()
        
        
        return true
    }
    
    
    func createMainNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        initialViewController.title = "Main"
        initialViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 0)
        return UINavigationController(rootViewController: initialViewController)
    }
    
    func createFavoriteNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        initialViewController.title = "Favorites"
        initialViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        return UINavigationController(rootViewController: initialViewController)
    }
    
    func createTabBarController() -> UITabBarController {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor     = .systemGreen
        UITabBar.appearance().barTintColor  = UIColor(named: "mainBackground")
        tabBar.viewControllers = [createMainNavigationController(), createFavoriteNavigationController()]
        return tabBar
    }
    
}

