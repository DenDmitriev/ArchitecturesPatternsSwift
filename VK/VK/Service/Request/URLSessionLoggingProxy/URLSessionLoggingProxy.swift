//
//  URLSessionLoggingProxy.swift
//  VK
//
//  Created by Denis Dmitriev on 15.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class URLSessionLoggingProxy {
    
    let urlSession: URLSession
    
    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }
    
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        
        print("by url: \(url)")
        
        return self.urlSession.dataTask(with: url) { (data, response, error) in
            completionHandler(data, response, error)
        }
    }
}
