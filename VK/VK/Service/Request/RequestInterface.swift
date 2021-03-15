//
//  RequestInterface.swift
//  VK
//
//  Created by Denis Dmitriev on 15.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

protocol RequestInterface {
    func request(_ method: Method, add parameters: [String:String]?, comletion: @escaping ((Data?) -> Void))
}
