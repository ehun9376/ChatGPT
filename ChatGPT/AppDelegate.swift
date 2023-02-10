//
//  AppDelegate.swift
//  ChatGPT
//
//  Created by 陳逸煌 on 2023/2/8.
//

import UIKit
import UserNotifications
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        application.registerForRemoteNotifications()
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = ChatTableViewController()
        window?.makeKeyAndVisible()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge, .carPlay], completionHandler: { (granted, error) in
            if granted {
                print("允許")
            } else {
                print("不允許")
            }
        })
        
        FirebaseApp.configure()
        
        UNUserNotificationCenter.current().delegate = self
        
        Messaging.messaging().delegate = self

        
        return true
    }
    

    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        APIService.shared.savedCompletionHandler = completionHandler
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
    }
    
    

}

extension AppDelegate: MessagingDelegate {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print(fcmToken)
    }
    
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification) async -> UNNotificationPresentationOptions {
        let userInfo = notification.request.content.userInfo

        print(userInfo)

        return [.badge, .alert, .sound]
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse) async {
      let userInfo = response.notification.request.content.userInfo
      print(userInfo)
    }
    
}
