//
//  GameQuestionsStrategy.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 01.03.2021.
//

import Foundation

final class GameQuestionsStrategy: QuestionsStrategy {
    
    func createQuestions() -> [Question] {
        return QuestionService.shared.questions(for: .game)
    }
}
