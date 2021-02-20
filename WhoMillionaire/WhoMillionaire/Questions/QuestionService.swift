//
//  QuestionService.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

class QuestionService {
    
    static let shared = QuestionService()
    
    public var questions: [Question]? { getQuestions() }
    
    init() {}
    
    private func getQuestions() -> [Question]? {
        guard
            let path = Bundle.main.path(forResource: "Questions", ofType: "plist"),
            let data = NSDictionary(contentsOfFile: path),
            let questions = (data as? [String: [String:Bool]])?.compactMap({ (key, value) -> Question in
                Question(question: key, answers: value)
            })
        else { return nil }
        return questions
    }
}
