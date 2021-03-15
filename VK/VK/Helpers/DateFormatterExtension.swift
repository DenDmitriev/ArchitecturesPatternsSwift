//
//  DateFormatterExtension.swift
//  VK
//
//  Created by Denis Dmitriev on 15.03.2021.
//  Copyright © 2021 Denis Dmitriev. All rights reserved.
//

import Foundation

extension DateFormatter {
    
    static var medium: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }
}
