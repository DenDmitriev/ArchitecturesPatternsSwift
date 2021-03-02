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
    
    public init() {}
    
    enum Kind {
        case game
        case user
    }
    
    public func questions(for kind: Kind = .game) -> [Question]? {
        let questions = getQuestions(for: kind)
        switch questions {
        case nil:
            do {
                guard let path = getPath(for: kind) else { return nil }
                let data = try Data(contentsOf: path)
                let questions = try JSONDecoder().decode([Question].self, from: data)
                switch kind {
                case .game:
                    questionsGameKeeper = questions
                case .user:
                    questionsUserKeeper = questions
                }
                return questions
            } catch {
                print(error)
                return nil
            }
        default:
            return questions
        }
    }
    
    private func getPath(for kind: Kind) -> URL? {
        switch kind {
        case .game:
            return Bundle.main.url(forResource: "Questions", withExtension: "json")
        case .user:
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        }
    }
    
    private func getQuestions(for kind: Kind) -> [Question]? {
        switch kind {
        case .game:
            return questionsGameKeeper
        case .user:
            return questionsUserKeeper
        }
    }
    
}
