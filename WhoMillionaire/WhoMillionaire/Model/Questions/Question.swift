//
//  Question.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

struct Question: Codable {
    var question: String
    var answers: [Answer]
    
    enum CodingKeys: String, CodingKey {
        case question
        case answers
    }
    
    init(custom question: String, with answers: [Answer]) {
        self.question = question
        self.answers = answers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.question = try container.decode(String.self, forKey: .question)
        self.answers = try container.decode([Answer].self, forKey: .answers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(answers, forKey: .answers)
        try container.encode(question, forKey: .question)
    }
    
}
