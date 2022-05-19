//
//  Constant.swift
//  Egarr
//
//  Created by Mohamed Elkilany on 4/1/21.
//


import Foundation
import Alamofire

struct Constants {
    
   static var state : StatisticsType = .goal
    
    
    struct ProductionServer {
        static let baseURL = "https://www.shattoor.com/api/api/"
    }
    
    
    struct APIParameterKey {
        
        static let phone = "phone"
        static let name = "name"
        static let password = "password"
        static let deviceType = "device_type"
        static let deviceID = "device_id"
        static let code = "code"
        static let currentPassword = "current_password"
        static let title = "title"
        static let complaint = "complaint"
        static let image = "avatar"
        static let categoryID = "category_id"
        static let serviceID = "service_id"
        static let typeID = "type_id"
        static let latFrom = "lat_from"
        static let lngFrom = "lng_from"
        static let addressFrom = "address_from"
        static let latTo = "lat_to"
        static let lngTo = "lng_to"
        
        static let lat = "lat"
        static let lng = "lng"
        static let addressTo = "address_to"
        static let productID = "product_id"
        static let regionID = "region_id"
        static let cityID = "city_id"
        
        static let timeFrom = "time_from"
        static let toFrom = "time_to"
        static let days = "days"
        static let extraFrom = "extra_from"
        static let extraTo = "extra_to"
        static let subcategoryID = "subcategory_id"
        static let subsectionID = "subsection_id"
        static let hidden = "hidden"
        static let type = "type"
        static let nameAr = "name_ar"
        static let nameEn = "name_en"
        static let receiverID = "receiver_id"
        static let conversationID = "conversation_id"
        static let page = "page"
        static let appType = "app_type"
        static let subcategories = "subcategories"
        
        static let deliveryPrice = "delivery_price"
        static let maximumDistance = "maximum_distance"
        static let differentDistance = "different_distance"
        static let checkDifferentDistance = "check_different_distance"
        static let deliveryService = "delivery_service"
        
        static let amount = "amount"
        static let message = "message"
        
        static let closed = "closed"
        static let maintenance = "maintenance"
        static let status = "status"
        static let orderID = "order_id"
        static let action = "action"
        static let cancelID = "cancel_id"
        static let comment = "comment"
        static let rate = "rate"
        static let imageID = "image_id"
        static let timeID = "time_id"
        static let notificationID = "notification_id"
        static let checkApp = "check-app"
        static let email = "email"
        static let providerID = "provider_id"
        static let distance = "distance"
        static let orders = "orders"
        static let text = "text"

        static let payment = "payment"
        static let total = "total"
        static let date = "date"
        static let time = "time"
        static let notes = "notes"
        static let reservationID = "reservation_id"
        static let reportID = "report_id"
        
      }
     
    enum InternetConnection :String {
        case noInternet = "Internet Connection Faild"
    }
    
    enum MoreStatus  {
        case delete
        case edit
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
    case lang = "lang"
}

enum ContentType: String {
    case json = "application/json"
    case deviceType = "ios"
}

enum RequestParams {
    case body(_:Parameters)
    case url(_:Parameters)
    case bodyAndURL(body:Parameters , url:Parameters)
}

enum alertButton : String {
    case ok = "Ok"
    case dismiss = "Dismiss"
}

enum alertTitle : String {
    case sucess = "Success"
    case error = "Error"
    case serverError = "Server Error"
    case noDataFound = "There is no Data Found"
    case logout = "Logout successfully"
    case dontHaveSubsection = "You Don't have Subsection Please Add Subsection"
}

enum UserDefaultsKeys : String {
    case home = "home"
    case userData = "userData"
}

enum UserActivity : String  {
    case isLogin = "isLogin"
    case isUserChild = "isUserChild"

    case isVisitor = "isVisitor"
    case checkApp = "checkApp"
}

enum GeneralTabel  {
    case sex
    case relativeRelation
    case language
    case Child

}

enum MapType {
    case LocationForProfile
}


public enum StatisticsType {
    case goal
    case activity
    case discountPoint
    case addPoint
    case reward
    
}
