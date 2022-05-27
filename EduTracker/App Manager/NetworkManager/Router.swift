//
//  Router.swift
//  Egarr
//
//  Created by Mohamed Elkilany on 4/1/21.
//

import Foundation
import Alamofire



enum Router: URLRequestConvertible {
    
    
    func asURLRequest() throws -> URLRequest {
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
        case .Login: return "Account/LogIn"
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
        
  }
}
