//
//  User.swift
//  VK
//
//  Created by Denis Dmitriev on 02.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

struct User {
    var id: Int
    var name: String
    var lastname: String
    var avatar: String
    
    var fullName: String {
        return name + " " + lastname
    }
}
