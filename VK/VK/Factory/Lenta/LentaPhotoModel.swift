//
//  LentaPhotoModel.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class LentaPhotoModel: LentaModel {
    
    let photos: [Photo]
    let photoMode: Post.AlbomMode
    
    init(photos: [Photo], mode: Post.AlbomMode) {
        self.photos = photos
        self.photoMode = mode
    }
}
