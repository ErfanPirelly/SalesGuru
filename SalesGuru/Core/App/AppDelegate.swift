//
//  AppDelegate.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/22/24.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    lazy var window: UIWindow? = UIWindow(frame: UIScreen.main.bounds)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        AppConfig.config()
        // MARK: - Firebase Config
        AppConfig.configureFirebase(notification: self, messagingDelegate: self, application: application)
        CoreDependence(window).execute()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        let view = SplashVC.instantiate(storyboard: .splash)
        self.window?.rootViewController = view
        self.window?.makeKeyAndVisible()
        return true
    }
}



// MARK: - configureFirebase messaging
extension AppDelegate: UNUserNotificationCenterDelegate, MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
           guard let fcmToken = fcmToken else { return }
        Logger.log(.info, fcmToken)
       }
       
       func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse) async {
           let userInfo = response.notification.request.content.userInfo
           // Print full message.
       }
       
       func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
           Messaging.messaging().apnsToken = deviceToken
       }
       
       func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           let userInfo = notification.request.content.userInfo
           Messaging.messaging().appDidReceiveMessage(userInfo)
           completionHandler([[.sound, .badge]])
       }
       
       func application(_ application: UIApplication,
       didReceiveRemoteNotification userInfo: [AnyHashable : Any],
          fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
         Messaging.messaging().appDidReceiveMessage(userInfo)
         completionHandler(.noData)
       }
}
