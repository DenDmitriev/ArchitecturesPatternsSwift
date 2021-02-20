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
    
    var questions: [Question]!
    
    weak var delegate: GameSessionDelegate!
    
    var result = Result(score: 0)
    var factor = 100
    let questionsCount: Int
    var questionsTrue: Int = 0 {
        willSet {
            factor *= newValue
        }
    }
    
    init() {
        guard let questionsFromService = QuestionService.shared.questions else {
            self.questions = []
            self.questionsCount = 0
            return
        }
        self.questions = questionsFromService
        self.questionsCount = questionsFromService.count
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
        Game.shared.addResult(result: result)
        delegate.endGame(with: result)
        print(result)
    }
}
