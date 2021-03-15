//
//  LentaFooterModel.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class LentaFooterModel: LentaModel {
    let likes: Int?
    let comments: Int?
    let reposts: Int?
    let views: Int?
    
    init(likes: Int?, comments: Int?, reposts: Int?, views: Int?) {
        self.likes = likes
        self.comments = comments
        self.reposts = reposts
        self.views = views
    }
}
