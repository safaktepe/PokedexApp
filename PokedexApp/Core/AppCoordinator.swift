//
//  AppCoordinator.swift
//  PokedexApp
//
//  Created by Mert Şafaktepe on 11.08.2022.
//

import Foundation
import UIKit


class AppCoordinator {
    
    let navController: UINavigationController
    
    init(navController: UINavigationController) {
        self.navController = navController
    }
    
    
    func start() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SplashViewController") as! SplashViewController
        initialViewController.showTabBarController = showTabBarController
        initialViewController.title = "Main"
        self.navController.pushViewController(initialViewController, animated: false)
    }
    
    private func showTabBarController() {
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor     = .systemGreen
        UITabBar.appearance().barTintColor  = UIColor(named: "mainBackground")
        tabBar.viewControllers = [createMainNavigationController(), createFavoriteNavigationController()]
        self.navController.viewControllers = [tabBar]
    }
    
    
    func createMainNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        initialViewController.title = "Main"
        initialViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 0)
        return UINavigationController(rootViewController: initialViewController)
    }
    
    func createFavoriteNavigationController() -> UINavigationController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
        initialViewController.title = "Favorites"
        initialViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        return UINavigationController(rootViewController: initialViewController)
    }
    
   
}
