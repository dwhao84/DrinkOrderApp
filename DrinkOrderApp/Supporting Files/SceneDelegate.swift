//
//  SceneDelegate.swift
//  DrinkOrderApp
//
//  Created by Da-wei Hao on 2024/2/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene      = (scene as? UIWindowScene) else { return }
        window                     = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene        = windowScene
        window?.rootViewController = createTheLoginVC()
        self.window?.makeKeyAndVisible()
    }
    
    func createTheLoginVC () -> UIViewController {
        let loginVC = LoginViewController()
        return loginVC
    }
    
//    func createTheHomePageNavigationVC () -> UINavigationController {
//        let homePageVC              = HomePageViewController()
//        let homePageNC              = UINavigationController(rootViewController: homePageVC)
//        homePageNC.tabBarItem.image = Images.homePage
//        homePageNC.tabBarItem.title = "Home"
//        return homePageNC
//    }
//
//    func createTheOrderListNavigationVC () -> UINavigationController {
//        let orderListVC              = OrderListViewController()
//        let orderListNC              = UINavigationController(rootViewController: orderListVC)
//        orderListNC.tabBarItem.image = Images.list
//        orderListNC.tabBarItem.title = "List"
//        return orderListNC
//    }
//    
//    func createTheSettingTableViewNavigationVC () -> UINavigationController {
//        let settingTableVC           = SettingTableViewController()
//        let settingTableNC           = UINavigationController(rootViewController: settingTableVC)
//        settingTableNC.tabBarItem.image = Images.setting
//        settingTableNC.tabBarItem.title = "Setting"
//        return settingTableNC
//    }
//    
//    func createTabBarController () -> UITabBarController {
//         let tabBarController                  = UITabBarController()
//         tabBarController.tabBar.barTintColor  = Colors.white
//         tabBarController.viewControllers      = [
//            createTheHomePageNavigationVC        (),
//            createTheOrderListNavigationVC       (),
//            createTheSettingTableViewNavigationVC()
//         ]
//         tabBarController.tabBar.tintColor     = Colors.kebukeBrown
//         tabBarController.tabBar.isTranslucent = true
//         let standardAppearance = UITabBarAppearance()
//         tabBarController.tabBar.standardAppearance = standardAppearance
//         tabBarController.tabBar.scrollEdgeAppearance = standardAppearance
//         return tabBarController
//     }
//    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

