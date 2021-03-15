//
//  RequestService.swift
//  VK
//
//  Created by Denis Dmitriev on 15.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class RequestService: RequestInterface {
    
    let session = Session.shared
 
    func request(_ method: Method, add parameters: [String:String]? = nil, comletion: @escaping ((Data?) -> Void)) {
        DispatchQueue.global().async {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.vk.com"
            components.path = method.path
            var queryItems = [
                URLQueryItem(name: "access_token", value: self.session.token),
                URLQueryItem(name: "v", value: "5.21")
            ]
            if let parameters = parameters {
                parameters.forEach { (key, value) in
                    queryItems.append(URLQueryItem(name: key, value: value))
                }
            }
            let methodQueryItems = method.parameters.map { URLQueryItem(name: $0, value: $1) }
            components.queryItems = queryItems + methodQueryItems
            
            guard let url = components.url
            else {
                comletion(nil)
                return
            }
            
            //let session = URLSession.shared
            let session = URLSessionLoggingProxy(urlSession: URLSession.shared)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if let error = error {
                    print(error)
                }
                comletion(data)
            }
            task.resume()
        }
    }
}
