//
//  HelperTools.swift
//  EduTracker
//
//  Created by Mohamed Elkilany on 17/05/2022.
//

import UIKit
import SwiftMessages

class HelperTools {
    
    static let shared = HelperTools()
    
    static let dafault = UserDefaults()
    static var langInChild = false
    
    static func isLogout(){
        dafault.removeObject(forKey:UserDefaultsKeys.userData.rawValue)
    }
    
//    static func getToken()->String?{
//        let data = try?  HelperTools.dafault.getObject(forKey:UserDefaultsKeys.userData.rawValue, castTo: UserModelResponse.self)
//        if let userData = data {
//            return userData.token
//        }
//        return ""
//    }
    
    static  func getPrice(price : String)->String{
        return " \(price) " + "SAR".localized
    }
    
    static func setBackButton(for Button: UIButton){
        if let lang = LocalizationManager.shared.getLanguage() {
            if lang == .Arabic {
                Button.setImage(#imageLiteral(resourceName: "LeftArrow"), for: .normal)
            }else{
                Button.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
            }
        }
    }
    
    static func setBackBarButton(_ title:String,_ viewController:UIViewController ){
        let backItem = UIBarButtonItem()
        backItem.title = title.localized
        let navbarFont = UIFont(name: "Cairo-Bold", size: 12)  ?? UIFont.systemFont(ofSize: 12)
        let barbuttonFont = UIFont(name: "Cairo-Bold", size: 15) ?? UIFont.systemFont(ofSize: 15)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.font: navbarFont, NSAttributedString.Key.foregroundColor:UIColor(named: "030414") ?? UIColor.black]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: barbuttonFont, NSAttributedString.Key.foregroundColor:UIColor(named: "030414") ?? UIColor.black], for: .normal)
        viewController.navigationController?.navigationBar.tintColor = UIColor(named: "030414")
        viewController.navigationController?.navigationBar.topItem?.backBarButtonItem = backItem
    }
    
    static func currentLanguage()-> LocalizationManager.Language?{
        if let lang = LocalizationManager.shared.getLanguage() {
            if lang == .English {
                return .English
            }else{
                return .Arabic
            }
        }
        return nil
    }
    
//    static func saveUserData(respons:UserModelResponse?){
//        guard let userData = respons else {return}
//        try? UserDefaultHelper.shared.setDataToDefault(userData, forKey: UserDefaultsKeys.userData.rawValue)
//    }
//
//    static func setTabBarAsRoot() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let ahjezTabBar = ExcellentTabBarController()
//        ahjezTabBar.selectedIndex = 0
//        appDelegate.window!.rootViewController = ahjezTabBar
//    }
    
    
//    static func setTabBarVC(Index:Int) {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let ahjezTabBar = ExcellentTabBarController()
//        ahjezTabBar.selectedIndex = Index
//        appDelegate.window!.rootViewController = ahjezTabBar
//    }
    
    static func isFirstLaunch()->Bool{
        if dafault.bool(forKey: "first Launch") == true  {
            dafault.set(true ,forKey:"first Launch")
            return false
        }else{
            dafault.set(true ,forKey:"first Launch")
            return true
        }
    }
    
    func confiugreCameraOptions(vc:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            vc.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func confiugreGallaryOption(vc:UIViewController){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.allowsEditing = false
            imagePicker.delegate = vc as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            vc.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    static  func chosseOptionAlert(imagePicker:UIImagePickerController, vc:UIViewController){
        let  alert = UIAlertController(title: "Choose Image".localized, message: "Pick Image From".localized, preferredStyle: .actionSheet)
        
        let galleryAction = UIAlertAction(title: "Gallery".localized, style: .default) { (btn) in
            imagePicker.sourceType = .photoLibrary
            HelperTools.shared.confiugreGallaryOption(vc: vc)
        }
        
        let cameraAction = UIAlertAction(title: "Camera".localized, style: .default) { (btn) in
            imagePicker.sourceType = .camera
            HelperTools.shared.confiugreCameraOptions(vc: vc)
        }
        
        let cancel  = UIAlertAction(title: "Cancel".localized, style: .cancel, handler: nil)
        alert.addAction(galleryAction)
        alert.addAction(cameraAction)
        alert.addAction(cancel)
        vc.present(alert, animated: true, completion: nil )
    }
    
    
    
    static func openWhatsApp(number : String){
        var fullMob = number
        fullMob = fullMob.replacingOccurrences(of: " ", with: "")
        fullMob = fullMob.replacingOccurrences(of: "+", with: "")
        fullMob = fullMob.replacingOccurrences(of: "-", with: "")
        let urlWhats = "https://wa.me/\(number)"
        if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
            if let whatsappURL = NSURL(string: urlString) {
                if UIApplication.shared.canOpenURL(whatsappURL as URL) {
                    UIApplication.shared.open(whatsappURL as URL, options: [:], completionHandler: { (Bool) in
                    })
                } else {
                    print("install whatApp")
                }
            }
        }
    }
    
    static  func callNumber(number:String){
        guard let url = URL(string: "tel://\(number)") else {return}
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    static func ShowIntervalMassge(massge:alertTitle? , key:String?){
        let view = MessageView.viewFromNib(layout: .messageView)
        view.configureTheme(.info)
        view.button?.isHidden = true
        view.configureDropShadow()
        SwiftMessages.defaultConfig.duration = .seconds(seconds: 3)
        view.bodyLabel?.font = UIFont(name: "Cairo-Bold", size: 16)
        view.configureContent(title:massge?.rawValue.localized ?? "" , body: key?.localized ?? "", iconImage: nil, iconText: "", buttonImage: nil, buttonTitle: "OK".localized) { _ in
            SwiftMessages.hide()}
        view.layoutMarginAdditions = UIEdgeInsets(top:20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: view)
        
    }
    
    static func ShowErrorMassge(massge:String , title:alertTitle){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.error)
        view.button?.isHidden = true
        view.backgroundView.backgroundColor = UIColor(named: "7966FD")
        view.configureDropShadow()
        SwiftMessages.defaultConfig.duration = .seconds(seconds: 3)
        view.bodyLabel?.font = UIFont(name: "Cairo-Bold", size: 16)
        view.configureContent(title:.none, body: massge.localized, iconImage: #imageLiteral(resourceName: "icons8-cancel-24") , iconText: .none, buttonImage: #imageLiteral(resourceName: "Cancel"), buttonTitle:nil) { _ in
            SwiftMessages.hide()
        }
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 12
        SwiftMessages.show(view: view)
    }
    
    static func ShowTrueMassge(massge:String , title:alertTitle){
        let view = MessageView.viewFromNib(layout: .cardView)
        view.configureTheme(.success)
        view.button?.isHidden = true
        view.configureDropShadow()
        SwiftMessages.defaultConfig.duration = .seconds(seconds: 3)
        view.configureContent(title:title.rawValue.localized, body: massge.localized, iconImage: #imageLiteral(resourceName: "true"), iconText: "", buttonImage:nil, buttonTitle: "OK".localized) { _ in
            SwiftMessages.hide()}
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        SwiftMessages.show(view: view)
    }
}
