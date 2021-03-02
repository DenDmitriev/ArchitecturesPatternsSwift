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
    
    weak var delegate: GameSessionDelegate!
    
    var questions: [Question] = []
    
    var current = CustomObservable<Int>(0)
    var percent = CustomObservable<Int>(0)
    var score = CustomObservable<Int>(0)
    
    var count: Int { questions.count }
    var factor: Int { (current.value) * 100 }
    
    var helpers: [Helpers : Bool] = [:]
    var hintUsageFacade: HintUsageFacade?
    
    var result: Result!
    
    init() {
        let questions = Game.shared.questionsStrategy.createQuestions()
        self.questions = Game.shared.sequenceStrategy.createQuestions(questions)
        
        self.result = Result()
        
        delegate = Game.shared
        
        Helpers.allCases.forEach { (helper) in
            helpers[helper] = true
        }
    }
    
    private func clearResult() {
        result = Result()
    }
}

extension GameSession: GameViewControllerDelegate {
    
    func usedHelper(_ helper: Helpers) {
        self.helpers[helper] = false
    }
    

    func progress() {
        
        current.value += 1
        
        let percentDouble = 100 * Double(current.value) / Double(count)
        percent.value = Int(percentDouble)
        
        score.value += factor
        
        result.score = score.value
        result.percent = percent.value
    }
    
    func endGame(_ check: Bool) {
        if !check { clearResult() }
        Game.shared.addResult(result: result)
        delegate.endGame(with: result)
    }
    
}
