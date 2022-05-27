//
//  NetworkManager.swift
//  Egarr
//
//  Created by Mohamed Elkilany on 4/1/21.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static func APIWithImage<T> (model: T.Type, urlPath:String,imageParameterName:String, image: UIImage?, params: [String: Any],completed:@escaping (_ respons: Any?,_ message:String? ) -> Void) where T : Decodable
    {
        let url = Constants.ProductionServer.baseURL + urlPath
        guard let  userUrl  = URL(string: url) else {return}
        
        var  headers: HTTPHeaders =  []
        headers = [
            HTTPHeaderField.acceptType.rawValue:ContentType.json.rawValue,
            HTTPHeaderField.contentType.rawValue : ContentType.json.rawValue ,
            HTTPHeaderField.lang.rawValue:LocalizationManager.shared.getLanguage()!.rawValue,
            HTTPHeaderField.authentication.rawValue:""
        ]
        
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in params {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if image != nil {
                guard let imageData  = image?.jpegData(compressionQuality: 0.2) else { return }
                multipartFormData.append( imageData , withName:imageParameterName, fileName: ".png", mimeType: "image/jpeg")
            }
            
        }, to: userUrl, method: .post , headers:headers).uploadProgress(closure: { (progress) in
            print("the Progress is \(progress)")
            
        }).responseJSON(completionHandler: { (response) in
            if let err = response.error{
                print("the error is \(err)")
                completed(nil,"no Internet")
                return
            }
            switch response.result{
            case .success(let value):
                let decoder = JSONDecoder()
                do{
                    let jsonData = try? JSONSerialization.data(withJSONObject:value)
                    let valueObject  = try decoder.decode(model, from: jsonData!)
                    completed(valueObject  ,nil)
                    
                    print("Ahjez Data valueObject \(valueObject)")
                }catch let error{
                    completed(nil,error.localizedDescription)
                    print("Ahjez error Data  \(error)")
                }
            case .failure(let error):
                completed(nil,error.localizedDescription)
                print("Ahjez: the error is \(error)")
            }
        })
    }
//
//
//    static func loginNetwork(username: String, password: String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.Login(username: username, password: password))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func registerParentNetwork(email: String, Password: String, ConfirmPassword: String, PhoneNumber: String, FullName: String, GenderId: String, CountryId: String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.RegisterParent(email: email, Password: Password, ConfirmPassword: ConfirmPassword, PhoneNumber: PhoneNumber, FullName: FullName, GenderId: GenderId, CountryId: CountryId))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getRelationsNetwork( completion:@escaping (AFResult<GeneralPopUpResponse>)->Void){
//        AF.request(Router.Relations)
//            .responseDecodable { (response: AFDataResponse<GeneralPopUpResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getParentKidsWithMoreDetailsNetwork( pageIndex:  String,completion:@escaping (AFResult<KidsResponse>)->Void){
//        AF.request(Router.ParentKidsWithMoreDetails(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<KidsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func changeAccountChangeProfileLanguage( languageID:  String,completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.AccountChangeProfileLanguage(languageID: languageID))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func changeKidAccountChangeProfileLanguage( languageID:  String,completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.changeKidProfileLanguage(languageID: languageID))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getParentKidsWithCompletionRateNetwork( pageIndex:  String,completion:@escaping (AFResult<HomeParentResponse>)->Void){
//        AF.request(Router.ParentKidsWithCompletionRate(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<HomeParentResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getTasksNetwork( type:  String,completion:@escaping (AFResult<TasksResponse>)->Void){
//        AF.request(Router.getTasks(type: type))
//            .responseDecodable { (response: AFDataResponse<TasksResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getKidsNetwork( completion:@escaping (AFResult<ParentKidsResponse>)->Void){
//        AF.request(Router.getKids)
//            .responseDecodable { (response: AFDataResponse<ParentKidsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getKidGoalsNetwork( pageIndex:String,kidId:String, completion:@escaping (AFResult<KidsGoalsAndActivityResponse>)->Void){
//        AF.request(Router.getKidGoals(pageIndex: pageIndex, kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<KidsGoalsAndActivityResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getKidActivitiesNetwork( pageIndex:String,kidId:String, completion:@escaping (AFResult<KidsGoalsAndActivityResponse>)->Void){
//        AF.request(Router.getKidActivities(pageIndex: pageIndex, kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<KidsGoalsAndActivityResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getGiftsNetwork( pageIndex:String, kidId:String,completion:@escaping (AFResult<GetGiftResponse>)->Void){
//        AF.request(Router.gifts(pageIndex: pageIndex, kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<GetGiftResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func acceptOrRefuseTaskNetwork(Id: String, accept: String, points: String,completion:@escaping (AFResult<GeneralResponseStringData>)->Void){
//        AF.request(Router.acceptOrRefuseTask(Id: Id, accept: accept, points: points))
//            .responseDecodable { (response: AFDataResponse<GeneralResponseStringData>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func acceptOrRefuseGiftNetwork(Id: String, accept: String,completion:@escaping (AFResult<GeneralResponseStringData>)->Void){
//        AF.request(Router.acceptOrRefuseGift(Id: Id, accept: accept))
//            .responseDecodable { (response: AFDataResponse<GeneralResponseStringData>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getKidsAwardHomeNetwork( pageIndex:String,kidId:String, completion:@escaping (AFResult<KidsAwardHomeResponse>)->Void){
//        AF.request(Router.getKidsAwardHome(pageIndex: pageIndex, kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<KidsAwardHomeResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getKidsDiscountHomeNetwork( pageIndex:String,kidId:String, completion:@escaping (AFResult<KidsAwardHomeResponse>)->Void){
//        AF.request(Router.getKidsDiscountHome(pageIndex: pageIndex, kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<KidsAwardHomeResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getNotificationsNetwork( pageIndex:String,kidId:String, completion:@escaping (AFResult<NotificationResponse>)->Void){
//        AF.request(Router.GetNotifications(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<NotificationResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//
//
//    static func addRewardAndDiscountHomeNetwork( PointTypeId: String, KidsProfileId: String, PointsObtained: String, Reason: String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.addRewardAndDiscountHome(PointTypeId: PointTypeId, KidsProfileId: KidsProfileId, PointsObtained: PointsObtained, Reason: PointsObtained))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func changePasswordNetwork( currentPassword: String, newPassword: String ,completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.changePasswordNetwork(currentPassword: currentPassword, newPassword: newPassword))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func childProfileFromParentNetwork( kidId: String, completion:@escaping (AFResult<ChildProfileFromParentResponse>)->Void){
//        AF.request(Router.getKidProfile(kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<ChildProfileFromParentResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func resendDiscountOrAwardNetwork( opId: String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.resendDiscountOrAward(opId: opId))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func resendAwardNetwork( opId: String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.resendAward(opId: opId))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//
//    static func getKidActivitiesOnProfileNetwork( pageIndex:String,kidId:String, completion:@escaping (AFResult<GetKidActivitiesOnProfileResponse>)->Void){
//        AF.request(Router.GetKidActivitiesOnProfile(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<GetKidActivitiesOnProfileResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//    static func getKidGoalsOnProfileNetwork( pageIndex:String,kidId:String, completion:@escaping (AFResult<GetKidActivitiesOnProfileResponse>)->Void){
//        AF.request(Router.GetKidGoalsOnProfile(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<GetKidActivitiesOnProfileResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getAppContactNetwork(  completion:@escaping (AFResult<AppContactResponse>)->Void){
//        AF.request(Router.AppContact)
//            .responseDecodable { (response: AFDataResponse<AppContactResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getHeaderNetwork(  completion:@escaping (AFResult<GetHeaderResponse>)->Void){
//        AF.request(Router.GetHeader)
//            .responseDecodable { (response: AFDataResponse<GetHeaderResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getAboutAppNetwork(  completion:@escaping (AFResult<GeneralResponseStringData>)->Void){
//        AF.request(Router.AboutApp)
//            .responseDecodable { (response: AFDataResponse<GeneralResponseStringData>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getKidLoginDataNetwork(  kidId:String , completion:@escaping (AFResult<ChildLoadingDataResponse>)->Void){
//        AF.request(Router.getKidLoginData(kidId: kidId, width: "100", height: "100"))
//            .responseDecodable { (response: AFDataResponse<ChildLoadingDataResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getSubscriptionsNetwork(  completion:@escaping (AFResult<subscriptionModel>)->Void){
//        AF.request(Router.GetSubscriptions)
//            .responseDecodable { (response: AFDataResponse<subscriptionModel>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func ChangeActivateStoreNetwork(isActive:String , completion:@escaping (AFResult<ChangeStoreActiviationResponse>)->Void){
//        AF.request(Router.ChangeActivateStore(isActive: isActive))
//            .responseDecodable { (response: AFDataResponse<ChangeStoreActiviationResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getActivateStoreNetwork( completion:@escaping (AFResult<ActiveStoreResponse>)->Void){
//        AF.request(Router.ActivateStore)
//            .responseDecodable { (response: AFDataResponse<ActiveStoreResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//
//    static func changeKidLoginDataNetwork( kidId: String, username: String, password: String,completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.ChangeKidLoginData(kidId: kidId, username: username, password: password))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getParentProfileDataNetwork(completion:@escaping (AFResult<ParentProfileDataResponse>)->Void){
//        AF.request(Router.GetParentProfileData)
//            .responseDecodable { (response: AFDataResponse<ParentProfileDataResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func editParentProfileNetwork(name: String, email: String, gender: String, phone: String , completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.editParentProfile(name: name, email: email, gender: gender, phone: phone))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//
//    static func getStatisticsActivitiesKid(  kidId:String , pageIndex:String,completion:@escaping (AFResult<StatisticsDetailsResponse>)->Void){
//        AF.request(Router.GetStatisticsActivitiesKid(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<StatisticsDetailsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getAffiliateProducts(pageIndex:String,completion:@escaping (AFResult<ShattorShopResponse>)->Void){
//        AF.request(Router.affiliateProducts(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<ShattorShopResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func GetStatisticsGoalsKid(  kidId:String , pageIndex:String,completion:@escaping (AFResult<StatisticsDetailsResponse>)->Void){
//        AF.request(Router.GetStatisticsGoalsKid(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<StatisticsDetailsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func GetStatisticsGiftsKid(  kidId:String , pageIndex:String,completion:@escaping (AFResult<StatisticsDetailsResponse>)->Void){
//        AF.request(Router.GetStatisticsGiftsKid(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<StatisticsDetailsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func showAds(showAds:String,completion:@escaping (AFResult<ShowAdsResponse>)->Void){
//        AF.request(Router.showAds(openAd: showAds))
//            .responseDecodable { (response: AFDataResponse<ShowAdsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//
//
//    static func GetStatisticsGrantKid(  kidId:String , pageIndex:String,completion:@escaping (AFResult<StatisticsDetailsResponse>)->Void){
//        AF.request(Router.GetStatisticsGrantKid(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<StatisticsDetailsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func GetStatisticsDeductionKid(  kidId:String , pageIndex:String,completion:@escaping (AFResult<StatisticsDetailsResponse>)->Void){
//        AF.request(Router.GetStatisticsDeductionKid(kidId: kidId, pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<StatisticsDetailsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func forgetPasswordNetwork(  email:String ,completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.forgetPassword(email: email))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func confirmCodeNetwork(  email:String ,code:String,completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.ConfirmCode(email: email , code: code))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//
//    static func createNewPasswordNetwork(  email:String ,NewPassword:String, RePassword:String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.CreateNewPassword(Email: email, NewPassword: NewPassword, RePassword: RePassword))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func deleteTaskNetwork(  taskId:String ,kidId:String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.DeleteTask(taskId: taskId, kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getTaskByIdNetwork(taskId:String , completion:@escaping (AFResult<TaskByIdResponse>)->Void){
//        AF.request(Router.getTaskById(taskById: taskId))
//            .responseDecodable { (response: AFDataResponse<TaskByIdResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getGiftByIdNetwork(giftId:String , completion:@escaping (AFResult<TaskByIdResponse>)->Void){
//        AF.request(Router.getGiftById(giftId: giftId))
//            .responseDecodable { (response: AFDataResponse<TaskByIdResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func deleteGiftNetwork(  giftId:String ,kidId:String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.DeleteGiftKid(giftId: giftId, kidId: kidId))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    // MARK: Child API
//
//    static func loginChildByUserName(userName:String ,password:String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.LoginChildByUserName(username: userName, password: password))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func loginChildByQRCode(qr:String, completion:@escaping (AFResult<UserModelResponse>)->Void){
//        AF.request(Router.LoginChildByQR(Qr: qr))
//            .responseDecodable { (response: AFDataResponse<UserModelResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getKidsDiscounts(pageIndex:String, completion:@escaping (AFResult<KidsDiscountsAndGrantsResponse>)->Void){
//        AF.request(Router.KidsDiscounts(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<KidsDiscountsAndGrantsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getKidsAward(pageIndex:String, completion:@escaping (AFResult<KidsDiscountsAndGrantsResponse>)->Void){
//        AF.request(Router.KidsAward(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<KidsDiscountsAndGrantsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func getKidsActivities(pageIndex:String, completion:@escaping (AFResult<KidsActivitiesAndGoalsResponse>)->Void){
//        AF.request(Router.KidsActivities(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<KidsActivitiesAndGoalsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getKidsGoals(pageIndex:String, completion:@escaping (AFResult<KidsActivitiesAndGoalsResponse>)->Void){
//        AF.request(Router.KidsGoals(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<KidsActivitiesAndGoalsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//
//    static func executeTask(KidsTaskId:String, completion:@escaping (AFResult<GeneralResponseStringData>)->Void){
//        AF.request(Router.ExecuteTask(KidsTaskId: KidsTaskId))
//            .responseDecodable { (response: AFDataResponse<GeneralResponseStringData>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getKidProfileData( completion:@escaping (AFResult<GetKidProfileDataResponse>)->Void){
//        AF.request(Router.GetKidProfileData)
//            .responseDecodable { (response: AFDataResponse<GetKidProfileDataResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func getKidGift(pageIndex:String, completion:@escaping (AFResult<GetKidGiftsResponse>)->Void){
//        AF.request(Router.GetGift(pageIndex: pageIndex))
//            .responseDecodable { (response: AFDataResponse<GetKidGiftsResponse>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
//
//    static func giftRequest(GiftId:String, completion:@escaping (AFResult<GeneralResponseStringData>)->Void){
//        AF.request(Router.GiftRequest(GiftId: GiftId))
//            .responseDecodable { (response: AFDataResponse<GeneralResponseStringData>) in
//                completion(response.result)
//                print("full Response = \(response.result)")
//            }
//    }
}


