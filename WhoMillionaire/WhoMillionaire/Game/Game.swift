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
    
    weak var gameSession: GameSession?
    
    weak var delegate: GameDelegate!
    
    private var careTaker = CareTaker()
    
    private init() {
        results = careTaker.loadResults()
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
        delegate.endGame(with: with.score)
    }
    
    
}
