//
//  Router.swift
//  Egarr
//
//  Created by Mohamed Elkilany on 4/1/21.
//

import Foundation
import Alamofire


//let deviceID = AppDelegate().pushTokenIfNeeded()

enum Router: URLRequestConvertible {
    case Login(username:String , password:String)
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
            
        case .Login:
            return .post
//        case .Relations:
//            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .Login                        : return "Account/LogIn"
        }
    }
    
    // MARK: - Parameters
    private var parameters: RequestParams? {
        //        let constants = Constants.APIParameterKey.self
        switch self {
            
        case let .Login(username, password):
            return.body([
                "username" :username,
                "password" :password
            ])
    }
    
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let fakeToken = "RIsEnhZYYbGuZwIQ7oFyhzrtYmbVWWZYEGPA2vrv-DD8gGoR83aZ5dGMpupA4F_2GRTGyr_Ge05M2n1fhnMij-gLJRmPCWDlB-snK1v8pI8QdcB59cF5vj28Ys4FMIJWyXsSK1ISB25LdRj3lKt_AXVJpDJRkL7U7VO9oBp2ZtGpn3kIfvpTVnA5vHnlqiy1FHR57h62a0rzGK9hqVMMlLlbpWjneg22Mn_AmbVzFc2n7pZSQMDgVBvJddyfY7G8DCyyTdZnm9125RbcZd77YuSJ9N-yqWg9rAigSM4tyO3oTaw7bU8i-K7y5y8yVpr-OmUNmlgf8f5vZq7AWgXrYqR8f-m3KdpkhXkPDmm6fF-_oUZzL2mmJ2etzO2-pyvzt3M6acWMNbaW7f4uaRcQq69vN7RUjyBGG28QnvAVoaBo-3mW3ZcjVqkKjv7BmL6JAcn--aDX50qvThVzHVLS-9XjobLngjSSOzDAqHEB6u0s3YXPphdjY5e751sv-5kkY1nMIhMdn1_XYrHcDMIYqA"
        let url = try Constants.ProductionServer.baseURL.asURL()
        let lang = HelperTools.currentLanguage()

        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        //        encoding: JSONEncoding.default
        
        // HTTTP Method
        urlRequest.httpMethod = method.rawValue
        // Common Headers
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        //        urlRequest.
        urlRequest.setValue(lang?.rawValue, forHTTPHeaderField: HTTPHeaderField.lang.rawValue)
        
        let ifUserChild = HelperTools.dafault.bool(forKey: UserActivity.isUserChild.rawValue)
        if  ifUserChild {
            if  let token = HelperTools.getToken() , token.isEmpty == false {
                urlRequest.setValue("\(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            }else{
                urlRequest.setValue(nil, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            }
        }else{
            if  let token = HelperTools.getToken() , token.isEmpty == false {
                urlRequest.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            }else{
                urlRequest.setValue(nil, forHTTPHeaderField: HTTPHeaderField.authentication.rawValue)
            }
        }
        
        if let parameters = parameters {
            
            switch parameters {
            case .body(let parameters):
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
                    
                }catch{
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
                
            case .url(let parameters):
                let queryParams = parameters.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
                
            case .bodyAndURL(let bodyParameters, let urlParameters):
                do {
                    urlRequest.httpBody = try JSONSerialization.data(withJSONObject: bodyParameters, options: [])
                } catch {
                    throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
                }
                let queryParams = urlParameters.map { pair  in
                    return URLQueryItem(name: pair.key, value: "\(pair.value)")
                }
                var components = URLComponents(string:url.appendingPathComponent(path).absoluteString)
                components?.queryItems = queryParams
                urlRequest.url = components?.url
            }
            
            print("The API Parameter is = \(parameters)")
        }
        //        print("dd",urlRequest.)
        print("urlRequest = \(String(describing: urlRequest.headers)) and component = \(String(describing: urlRequest.allHTTPHeaderFields))  , \(String(describing: urlRequest.httpMethod)), \(String(describing: urlRequest.url))  , \(String(describing: urlRequest.httpBody))" )
        
        return urlRequest
    }
  }
}
