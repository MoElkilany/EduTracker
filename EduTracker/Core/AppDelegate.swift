//
//  AppDelegate.swift
//  EduTracker
//
//  Created by Mohamed Elkilany on 16/04/2022.
//


import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
//        LocalizationManager.shared.setAppInnitLanguage()
//        LocalizationManager.shared.delegate = self
        IQKeyboardManager.shared.enable  = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
       let splashNC  =  ViewController()
       window?.rootViewController = splashNC
       window?.makeKeyAndVisible()
        
        return true
    }
}

