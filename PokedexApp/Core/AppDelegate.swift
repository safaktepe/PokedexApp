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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
        let navigation = UINavigationController(rootViewController: initialViewController)
        self.window?.rootViewController = navigation
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

