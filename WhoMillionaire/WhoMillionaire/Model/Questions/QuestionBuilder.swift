//
//  QuestionBuilder.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 28.02.2021.
//

import Foundation

class QuestionBuilder {
    
    enum QuestionBuilderError: Error {
        case invalidQuestion
        case invalidAnswers
        case repeatAnswer
        case notEnoughAnswers(answersNeeded: Int, youAnswersCount: Int)
    }
    
    var question: String?
    var answers: [Answer]?
    
    func setQuestion(_ question: Question) {
        self.question = question.question
        self.answers = question.answers
    }
    
    func build() throws -> Question {
        
        guard let question = self.question,
              question != ""
        else { throw QuestionBuilderError.invalidQuestion }
        
        guard
            let answers = self.answers,
            noEmptyAnswer(answers)
        else { throw QuestionBuilderError.invalidAnswers }
        
        guard answers.count == 4 else { throw QuestionBuilderError.notEnoughAnswers(answersNeeded: 4, youAnswersCount: answers.count) }
        
        guard noDuplicate(answers) else { throw QuestionBuilderError.repeatAnswer }
        
        return Question(custom: question, with: answers)
    }
    
    //MARK: - Cheker
    
    private func noEmptyAnswer(_ answers: [Answer]) -> Bool {
        let check = answers.map { (answer) -> Bool in
            answer.answer != ""
        }
        if check.contains(false) {
            return false
        } else {
            return true
        }
    }
    
    private func noDuplicate(_ answers: [Answer]) -> Bool {
        return Set(answers.map { $0.answer }).count == answers.count
    }
    
}
