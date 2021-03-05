//
//  Format.swift
//  VK
//
//  Created by Denis Dmitriev on 28.01.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

final class Format {
    
    static let shared = Format()
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    
}
