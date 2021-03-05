//
//  LentaFooterModelFactory.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class LentaFooterModelFactory: LentaModelFactory {
    
    func constractViewModel(from post: Post) -> LentaModel {
        return LentaFooterModel(likes: post.likes?.count, comments: post.comments?.count, reposts: post.reposts?.count, views: post.views?.count)
    }
}
