//
//  AppDelegate.swift
//  DrinkOrderApp
//
//  Created by Da-wei Hao on 2024/2/22.
//

import UIKit
import IQKeyboardManagerSwift
import Firebase
import FirebaseAuth

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Import the IQKeyboardManager, when user using the textField, it'll automatically adjust the view's height.
        IQKeyboardManager.shared.enable = true
        // Make sure the FirebaseApp is enable to see.
        FirebaseApp.configure()
        // Ask the UINavigationBar appearance's tintColor
        UINavigationBar.appearance().tintColor = Colors.kebukeBrown
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

