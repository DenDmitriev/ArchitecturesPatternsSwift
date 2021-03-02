//
//  QuestionService.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
//

import Foundation

class QuestionService {
    
    static let shared = QuestionService()
    
    private var questionsGameKeeper: [Question]?
    private var questionsUserKeeper: [Question]?
    
    private var caretaker = QuestionCaretaker()
    
    public init() {}
    
    public func questions(for kind: QuestionType = .game) -> [Question] {
        let questions = getQuestions(for: kind)
        switch questions {
        case nil:
            return caretaker.loadQuestion(for: kind)
        default:
            return questions ?? []
        }
    }
    
    func saveQuestions(_ questions: [Question]) {
        caretaker.saveQuestons(questions: questions)
    }
    
    func saveCacheQuestions(_ questions: [Question]) {
        questionsUserKeeper = questions
    }
    
    
    
    private func getQuestions(for kind: QuestionType) -> [Question]? {
        switch kind {
        case .game:
            return questionsGameKeeper
        case .user:
            return questionsUserKeeper
        }
    }
    
}
