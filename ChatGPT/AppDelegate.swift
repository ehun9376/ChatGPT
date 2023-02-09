//
//  AppDelegate.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/8.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ChatTableViewController()
        window?.makeKeyAndVisible()
        return true
    }


}

