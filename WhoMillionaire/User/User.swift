//
//  User.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 24.02.2021.
//

import Foundation

final class User: Codable {
    
    var shuffle: Bool
    
    init() {
        //Default settings
        shuffle = false
    }
    
}
