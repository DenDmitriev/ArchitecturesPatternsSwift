//
//  SeriasSequenceStrategy.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 24.02.2021.
//

import Foundation

final class SeriasSequenceStrategy: SequenceStrategy {
    
    func createQuestions() -> [Question] {
        return QuestionService.shared.questions()
    }
}
