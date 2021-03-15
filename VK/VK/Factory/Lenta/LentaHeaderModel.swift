//
//  LentaHeaderModel.swift
//  VK
//
//  Created by Denis Dmitriev on 04.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class LentaHeaderModel: LentaModel {
    let avatar: URL
    let name: String
    let date: TimeInterval
    
    init(avatar: URL, name: String, date: TimeInterval) {
        self.avatar = avatar
        self.name = name
        self.date = date
    }
}
