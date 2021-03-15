//
//  RequestLoggingProxy.swift
//  VK
//
//  Created by Denis Dmitriev on 15.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class RequestLoggingProxy: RequestInterface {
    
    let requestService: RequestInterface
    
    init(requestService: RequestInterface) {
        self.requestService = requestService
    }
    
    func request(_ method: Method, add parameters: [String : String]? = nil, comletion: @escaping ((Data?) -> Void)) {
        
        if let parameters = parameters {
            print("Request for method \(method) with parameters: \(parameters)")
        } else {
            print("Request for method \(method)")
        }
        
        requestService.request(method, add: parameters, comletion: comletion)
    }
}
