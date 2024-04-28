//
//  AppDelegate.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/22/24.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = CleanNavigation(rootViewController: HomeVC())
        self.window?.makeKeyAndVisible()
        return true
    }
}
