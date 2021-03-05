//
//  LentaPhotoModelFactory.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class LentaPhotoModelFactory: LentaModelFactory {
    func constractViewModel(from post: Post) -> LentaModel {
        return LentaPhotoModel(photos: post.photos ?? [], mode: post.photoMode ?? .empty)
    }
}
