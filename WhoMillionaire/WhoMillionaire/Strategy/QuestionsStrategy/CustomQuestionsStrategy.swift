//
//  CustomQuestionsStrategy.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 01.03.2021.
//

import Foundation

final class CustomQuestionsStrategy: QuestionsStrategy {
    
    func createQuestions() -> [Question] {
        let userQuestions = QuestionService.shared.questions(for: .user)
        let gameQuestions = QuestionService.shared.questions(for: .game)
        return gameQuestions + userQuestions
    }
}


