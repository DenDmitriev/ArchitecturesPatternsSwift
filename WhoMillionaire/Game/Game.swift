//
//  Game.swift
//  WhoMillionaire
//
//  Created by Denis Dmitriev on 20.02.2021.
// Игра синглтон

import Foundation

protocol GameDelegate: AnyObject {
    func endGame(with score: Int)
}

class Game {
    
    static let shared = Game()
    
    var user: User!
    
    weak var gameSession: GameSession?
    
    weak var delegate: GameDelegate!
    
    private var careTaker = CareTaker()
    
    var sequenceStrategy: SequenceStrategy {
        self.user.shuffle ? ShuffleSequenceStrategy() : SeriasSequenceStrategy()
    }
    
    private init() {
        results = careTaker.loadResults()
        user = careTaker.loadUser()
    }
    
    private(set) var results: [Result] {
        didSet {
            careTaker.saveResults(results: results)
        }
    }
    
    func addResult(result: Result) {
        results.append(result)
    }
    
    func clearResults() {
        results.removeAll()
    }

}

extension Game: GameSessionDelegate {
    func endGame(with: Result) {
        gameSession = nil
        delegate.endGame(with: with.score)
    }
    
    
}
