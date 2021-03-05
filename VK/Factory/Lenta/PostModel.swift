//
//  PostModel.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class PostModel {
    let header: LentaHeaderModel?
    var text: LentaTextModel?
    let photo: LentaPhotoModel?
    let footer: LentaFooterModel?
    
    init(header: LentaHeaderModel? = nil, text: LentaTextModel? = nil, photo: LentaPhotoModel? = nil, footer: LentaFooterModel? = nil) {
        self.header = header
        self.text = text
        self.photo = photo
        self.footer = footer
    }
}
