//
//  Question.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

struct Question: Codable {
    let question: String
    let answers: [String:Bool]
    
    enum CodingKeys: String, CodingKey {
        case question
        case answers
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.question = try container.decode(String.self, forKey: .question)
        self.answers = try container.decode([String:Bool].self, forKey: .answers)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode (question, forKey: .question)
        try container.encode (answers, forKey: .answers)
        print(container)
    }
    
}
