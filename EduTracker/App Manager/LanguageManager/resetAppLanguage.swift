//
//  resetAppLanguage.swift
//  Egarr
//
//  Created by Mohamed Elkilany on 4/1/21.
//

import UIKit

extension AppDelegate :LocalizationDelegate {
    
    func resetApp() {
        
        guard let window = window else {return}
        
        let changeFromSplash =  HelperTools.dafault.bool(forKey: "changeFromSplash")
        let changeLang =  HelperTools.dafault.bool(forKey: "changeLanguageFromParentModel")
        let changeKidsLang =  HelperTools.dafault.bool(forKey: "changeLanguageFromKIDSModel")

        if changeFromSplash {
            let vc  = UIViewController()
            window.rootViewController = vc
        }else{
           
            if changeLang {
//                let mainHomeVC = UINavigationController(rootViewController: MainVC())
//                window.rootViewController = mainHomeVC
//                HelperTools.setTabBarAsRoot()
            }else if changeKidsLang {
                let childHomeVC = UINavigationController(rootViewController: UIViewController())
                window.rootViewController = childHomeVC
            }
        }
        
        
        let options :UIView.AnimationOptions = .transitionCrossDissolve
        let duration : TimeInterval = 0.3
        UIView.transition(with: window, duration: duration, options: options, animations: nil, completion: nil)
    }
}

