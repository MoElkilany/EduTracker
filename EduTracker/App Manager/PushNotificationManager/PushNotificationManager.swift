//
//  PushNotificationManager.swift
//  Egarr
//
//  Created by Mohamed Elkilany on 4/1/21.
////
//
//import UIKit
//import FirebaseMessaging
//
//extension AppDelegate : MessagingDelegate{
//
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//        print("Firebase registration token: \(String(describing: fcmToken))")
//        let dataDict:[String: String] = ["token": fcmToken ?? ""]
//        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)
//    }
//    
//    func pushTokenIfNeeded() -> String {
//        if let token = Messaging.messaging().fcmToken {
//            UserDefaults.standard.set(token, forKey: "deviceID")
//            print("Firebase registration token is = \(token)")
//            return token
//        }else{
//            return ""
//        }
//    }
//}
//
//@available(iOS 10, *)
//extension AppDelegate : UNUserNotificationCenterDelegate {
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        print("RESPONSE\(response)")
//        
//        let userInfo = response.notification.request.content.userInfo
//        let targetValue = userInfo[AnyHashable("type")] as? String
//        print("userInfo",userInfo)
//        if targetValue == "notification" {
//        }else if  targetValue  == "privet_notification"{
//        }else if targetValue == "user_deleted"{
//            HelperTools.isLogout()
//        }else if targetValue == "public_notification"{
//        }else if targetValue == "block" {
//            HelperTools.isLogout()
//        }
//        completionHandler()
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
//    }
//    
//    func userNotificationCenter(_ center: UNUserNotificationCenter,
//                                willPresent notification: UNNotification,
//                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        let userInfo = notification.request.content.userInfo
//        
//        // Print full message.
//        print(userInfo)
//        
//        let targetValue = userInfo[AnyHashable("type")] as? String
//        if targetValue == "notification" {
//        }else if  targetValue  == "privet_notification"{
//        }else if targetValue == "user_deleted"{
//            HelperTools.isLogout()
//        }else if targetValue == "public_notification"{
//        }else if targetValue == "block" {
//            HelperTools.isLogout()
//        }
//        // Change this to your preferred presentation option
//        completionHandler([[.alert, .badge,.sound]])
//    }
//}
//
//
//
//
//
