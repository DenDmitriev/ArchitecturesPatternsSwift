//
//  ShuffleSequenceStrategy.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 24.02.2021.
//

import Foundation

final class ShuffleSequenceStrategy: SequenceStrategy {
    
    func createQuestions(_ questions: [Question]) -> [Question] {
        return questions.shuffled()
    }
}
