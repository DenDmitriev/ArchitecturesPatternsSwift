//
//  Session.swift
//  VK
//
//  Created by Denis Dmitriev on 25.07.2020.
//  Copyright © 2020 Denis Dmitriev. All rights reserved.
//

import Foundation

class Session: CustomStringConvertible {
    
    static let shared: Session = Session()
    
    private init() {}
    
    var token: String = ""
    var userID: String = ""
 
    var description: String {
        return "User ID: \(userID)\nToken: \(token)"
    }
    
    func sessionCreate(token: String?, userID: String?) {
        let session = Session.shared
        session.token = token ?? "No token"
        session.userID = userID ?? "No userID"
        print(session.description)
    }
    
}


