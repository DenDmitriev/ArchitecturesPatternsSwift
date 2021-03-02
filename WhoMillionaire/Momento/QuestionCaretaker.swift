//
//  QuestionCaretaker.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 01.03.2021.
//

import Foundation

class QuestionCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    func saveQuestons(questions: [Question]) {
        
        let updatedQuestions = QuestionService.shared.questions(for: .user) + questions
        
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        
        guard let path = documentDirectory?.appendingPathComponent("UserQuestions").appendingPathExtension("json") else { return }

        do {
            let data = try encoder.encode(updatedQuestions)
            try data.write(to: path)
        } catch {
            print(error)
        }
    }
    
    func loadQuestion(for kind: QuestionType) -> [Question] {
        do {
            guard let path = getPath(for: kind) else { return [] }
            let data = try Data(contentsOf: path)
            let questions = try JSONDecoder().decode([Question].self, from: data)
            QuestionService.shared.saveCacheQuestions(questions)
            return questions
        } catch {
            print(error)
            return []
        }
    }
    
    private func getPath(for kind: QuestionType) -> URL? {
        switch kind {
        case .game:
            return Bundle.main.url(forResource: "Questions", withExtension: "json")
        case .user:
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
            guard
                let path = documentDirectory?.appendingPathComponent("UserQuestions").appendingPathExtension("json"),
                FileManager.default.fileExists(atPath: path.path)
            else { return nil }
            return path
        }
    }
}
