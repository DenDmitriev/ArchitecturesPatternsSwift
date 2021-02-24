//
//  Result.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

struct Result: Codable {
    let date: String
    var score: Int = 0
    var percent: Int = 0
    
    init() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MMM d, hh:mm:ss"
        self.date = dateFormatter.string(from: Date())
    }
}
