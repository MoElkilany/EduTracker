//
//  String+Extentions.swift
//  EduTracker
//
//  Created by Mohamed Elkilany on 17/05/2022.
//

import Foundation
extension String {
    var localized:String{
        return LocalizationManager.shared.localizedString(for: self, value: "")
    }
    
}
