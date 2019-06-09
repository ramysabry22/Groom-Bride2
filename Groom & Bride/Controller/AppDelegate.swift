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
        IQKeyboardManager.shared.previousNextDisplayMode = .alwaysShow
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        
        if let loggedInClient = defaults.dictionary(forKey: "loggedInClient"){
                HelperData.sharedInstance.loggedInClient._id = loggedInClient["_id"] as! String
                HelperData.sharedInstance.loggedInClient.userName = loggedInClient["userName"] as! String
                HelperData.sharedInstance.loggedInClient.userEmail = loggedInClient["userEmail"] as! String
        }
        
        return true
    }
    
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
  //      print("registered", deviceToken)
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().subscribe(toTopic: "highScores") { error in
            if let err = error {
                print("Errorrrrrr",err)
                return
            }
      //      print("Subscribed to highScores topic")
        }
    }
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
//        print("Registered with FCM Token: ",fcmToken)
//        print("****************************")
//        print("/n")
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
    //    print("Unable to register for remote notifications: \(error.localizedDescription)")
    }
   //  listen for user notification
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler(.alert)
    }
    
    private func attempRegisterForNotifications(application: UIApplication){
        
        Messaging.messaging().delegate = self
        UNUserNotificationCenter.current().delegate = self
        
        // user notification auth
        let options: UNAuthorizationOptions = [.alert, .badge, .sound]
                UNUserNotificationCenter.current().requestAuthorization(options: options) { (granted, err) in
//            if let error = err {
//              //  print("failed authurisation",error)
//            }
//            if granted {
//              //  print("granted")
//            }
//            else {
//              //  print("auth denied")
//            }
        }
        
        
        application.registerForRemoteNotifications()
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     // application.applicationIconBadgeNumber = 0
          //   application.applicationIconBadgeNumber = application.applicationIconBadgeNumber + 1
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

