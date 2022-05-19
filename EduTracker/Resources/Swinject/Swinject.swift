//
//  Swinject.swift
//  EduTracker
//
//  Created by Mohamed Elkilany on 17/05/2022.
//

import Swinject

struct Swinject {
    
    private static let container = Container()
    static let synchronizedContainer = container.synchronize()
    
    private init() {}
    
    public static func register(){
//        registerHomeVMs()
    }
    
}







/*
 private static func registerHomeVMs() {

     container.register(HomeViewModel.self) { _ in
         HomeViewModel()
     }
     container.register(HomeSectionsViewModel.self){ _ in
         HomeSectionsViewModel()
     }
     
     container.register(HomeAnnouncementViewModel.self){ _ in
         HomeAnnouncementViewModel()
     }
     
     container.register(AnnouncementsViewModel.self){ _ in
         AnnouncementsViewModel()
     }
     container.register(SurveysViewModel.self){ _ in
         SurveysViewModel()
     }
     
     container.register(HomeNewsViewModel.self) { _ in
         HomeNewsViewModel()
     }
     container.register(HomeHealthInfoViewModel.self) { _ in
         HomeHealthInfoViewModel()
     }
     container.register(HomeSurveysViewModel.self) { _ in
         HomeSurveysViewModel()
     }
     container.register(HealthDataViewModel.self) { _ in
         HealthDataViewModel()
     }
     
 }
 */
