//
//  LentaTextModelFactory.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

class LentaTextModelFactory: LentaModelFactory {
    
    func constractViewModel(from post: Post) -> LentaModel {
        return LentaTextModel(text: post.text ?? "", mode: post.textMode)
    }
    
}
