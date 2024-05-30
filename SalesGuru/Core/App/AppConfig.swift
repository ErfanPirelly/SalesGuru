//
//  AppConfig.swift
//  SalesGuru
//
//  Created by Erfan mac mini on 4/30/24.
//

import UIKit
import IQKeyboardManagerSwift
import FirebaseMessaging
import FirebaseCore

struct AppConfig {
    static func config() {
        keyboardManagerConfig()
        UITableViewCell.appearance().backgroundColor = .clear
        UITableViewCell.appearance().contentView.backgroundColor = .clear
        UITableViewCell.appearance().selectionStyle = .none
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .clear
        
        UICollectionView.appearance().backgroundColor = .clear
        UICollectionViewCell.appearance().backgroundColor = .clear
        UICollectionViewCell.appearance().contentView.backgroundColor = .clear
    }
    
    
    public static func keyboardManagerConfig() {
        let keyboardManager = IQKeyboardManager.shared
        keyboardManager.enabledTouchResignedClasses = [UIViewController.self]
        keyboardManager.shouldResignOnTouchOutside = true
        keyboardManager.enable = true
        keyboardManager.toolbarTintColor = .ui.label
        keyboardManager.toolbarBarTintColor = .ui.primaryBack
        keyboardManager.toolbarDoneBarButtonItemText = "Done"
        keyboardManager.enableAutoToolbar = true
        keyboardManager.disabledToolbarClasses = [ConversationVC.self]
    }
    
    
    static func configureFirebase(notification: UNUserNotificationCenterDelegate,
                                  messagingDelegate: MessagingDelegate,
                                  application: UIApplication) {
        FirebaseApp.configure()
        UNUserNotificationCenter.current().delegate = notification
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in })
        application.registerForRemoteNotifications()
        Messaging.messaging().delegate = messagingDelegate
        Messaging.messaging().isAutoInitEnabled = true
    }
}
