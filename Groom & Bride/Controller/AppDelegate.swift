//
//  AppDelegate.swift
//  Groom & Bride
//
//  Created by Ramy Ayman Sabry on 3/3/19.
//  Copyright © 2019 Ramy Ayman Sabry. All rights reserved.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift
import UserNotifications
import FirebaseMessaging


let defaults = UserDefaults.standard
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, MessagingDelegate, UNUserNotificationCenterDelegate{

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        FirebaseApp.configure()
        attempRegisterForNotifications(application: application)
        
        application.applicationIconBadgeNumber = 0
        
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysHide
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        
        if let loggedInClient = defaults.dictionary(forKey: "loggedInClient"){
            HelperData.sharedInstance.loggedInClient._id = loggedInClient["_id"] as! String
            HelperData.sharedInstance.loggedInClient.userName = loggedInClient["userName"] as! String
            HelperData.sharedInstance.loggedInClient.userEmail = loggedInClient["userEmail"] as! String
            HelperData.sharedInstance.loggedInClient.token = loggedInClient["token"] as! String
        }
        
        return true
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("Registred for notifications, DeviceToken: ", deviceToken)
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().subscribe(toTopic: "GroomAndBrideNews") { error in
            if let err = error {
                print("\n Error subscribing to topic 'GroomAndBrideNews'",err)
                return
            }
              print("\n Subscribed to topic 'GroomAndBrideNews' successfully")
        }
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Registered with FCM Token: ",fcmToken)
        print("****************************")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    //    print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
    // GroomAndBrideNews
    
   //  listen for user notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert,.sound])
    }
    private func attempRegisterForNotifications(application: UIApplication){
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        // User notification authorization
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, err) in
            if let error = err {
              print("Failed to request authorization",error)
                return
            }
            
            if granted {
                print("Notifications auth granted!!")
            }
            else {
                print("Notifications auth denied!!")
            }
        }
        
        application.registerForRemoteNotifications()
    }
    
    
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
      
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
   
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
       
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
          application.applicationIconBadgeNumber = 0
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }


}

