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
    
    public init() {
    }
    
    var kind: Kind = .game
    
    enum Kind {
        case game
        case user
    }
    
    public func questions(for kind: Kind = .game) -> [Question] {
        let questions = getQuestions(for: kind)
        switch questions {
        case nil:
            do {
                guard let path = getPath(for: kind) else { return [] }
                let data = try Data(contentsOf: path)
                let questions = try JSONDecoder().decode([Question].self, from: data)
                saveQuestions(for: kind, questions)
                return questions
            } catch {
                print(error)
                return []
            }
        default:
            return questions ?? []
        }
    }
    
    private func getPath(for kind: Kind) -> URL? {
        switch kind {
        case .game:
            return Bundle.main.url(forResource: "Questions", withExtension: "json")
        case .user:
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            guard
                let path = documentDirectory?.appendingPathComponent("UserQuestions").appendingPathExtension("json"),
                FileManager.default.fileExists(atPath: path.absoluteString)
            else { return nil }
            return path
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
    
    private func saveQuestions(for kind: Kind,_ questions: [Question]) {
        switch kind {
        case .game:
            questionsGameKeeper = questions
        case .user:
            questionsUserKeeper = questions
        }
    }
    
}
