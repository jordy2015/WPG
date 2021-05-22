//
//  ApiClient.swift
//  WPG
//
//  Created by Jordy Gonzalez on 22/05/21.
//

import Foundation
import CodableAlamofire
import Alamofire

class ApiClient {
    static let `default` = ApiClient()
    
    func performRequest<T: Decodable>(to url: String,
                                      httpMethod: HttpMethod,
                                      keyPath: String? = nil,
                                      body: [String: AnyObject]? = nil,
                                      completitionHandler: @escaping(_ response: T?, _ error: Error?) -> Void
    ) {
      AF.request(url,
                 method: HTTPMethod(rawValue: httpMethod.rawValue.uppercased()),
                 parameters: body)
        .validate()
        .responseDecodableObject(keyPath: keyPath) { (response: AFDataResponse<T>) in
          if let result = response.value {
            completitionHandler(result, nil)
          }
          
          if let error = response.error {
            completitionHandler(nil, error)
          }
        }
    }
    
    func hasConnection() -> Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}

enum HttpMethod: String {
  case Post
  case Get
  case Delete
}
