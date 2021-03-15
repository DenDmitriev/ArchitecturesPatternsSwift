//
//  Size.swift
//  VK
//
//  Created by Denis Dmitriev on 15.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import UIKit

enum Size {
    
    enum Post {
        static let zero: CGFloat = 0
        static let text: CGFloat = 100
        static let photo: CGFloat = 250
        static let button: CGFloat = 33
        static let seporator: CGFloat = 4
    }
    
    enum Albom {
        static let seporator: CGFloat = 8
        static let fontSize: CGFloat = 17
        static let cornerRadius: CGFloat = 8
        static let inset: CGFloat = 8
        static let itemsPerLine: CGFloat = 2
        static let zero: CGFloat = 0
    }
    
    enum Gallery {
        static let seporator: CGFloat = 4
        static let inset: CGFloat = 4
        static let zero: CGFloat = 0
    }
    
    enum Carusel {
        static let separator: CGFloat = 10
        static let duration: TimeInterval = 0.5
    }
}
