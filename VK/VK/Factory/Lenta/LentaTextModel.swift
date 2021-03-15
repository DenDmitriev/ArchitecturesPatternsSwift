//
//  LentaTextModel.swift
//  VK
//
//  Created by Denis Dmitriev on 05.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

class LentaTextModel: LentaModel {
    
    let text: String
    var textMode: Post.TextMode
    
    init(text: String, mode: Post.TextMode) {
        self.text = text
        self.textMode = mode
    }
}
