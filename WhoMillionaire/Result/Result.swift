//
//  Result.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

struct Result: Codable {
    let date: String
    var score: Int
    
    init(score: Int) {
        self.score = score
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "MMM d, hh:mm:ss"
        self.date = dateFormatter.string(from: Date())
    }
}

