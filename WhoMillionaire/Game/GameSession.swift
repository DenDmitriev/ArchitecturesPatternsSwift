//
//  GameSession.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
// Текущая игра

import Foundation

protocol GameSessionDelegate: AnyObject {
    func endGame(with: Result)
}

class GameSession {
    
    var questions: [Question] = []
    
    weak var delegate: GameSessionDelegate!
    
    var result = Result()
    
    var questionsCount: Int { questions.count }
    var factor = 100
    var questionsTrue: Int = 0 {
        willSet {
            factor *= newValue
        }
    }
    
    init() {
        self.questions = Game.shared.sequenceStrategy.createQuestions()
        delegate = Game.shared
    }
}

extension GameSession: GameViewControllerDelegate {

    func progress(for index: Int, with check: Bool) {
        if index < questionsCount {
            if check {
                questionsTrue += 1
                result.score += factor
            }
        }
    }
    
    func endGame() {
        result.percent = Int((( Double(questionsTrue) / Double(questionsCount) ) * 100).rounded(.down))
        Game.shared.addResult(result: result)
        delegate.endGame(with: result)
        print(result)
    }
}
