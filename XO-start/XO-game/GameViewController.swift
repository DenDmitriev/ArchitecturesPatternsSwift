//
//  GameViewController.swift
//  XO-game
//
//  Created by Evgeny Kireev on 25/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    private let gameBoard = Gameboard()
    private var currentState: GameState! {
        didSet {
            currentState.begin()
        }
    }
    private lazy var referee = Referee(gameboard: gameBoard)
    
    private var counter = 0
    
    @IBOutlet var gameboardView: GameboardView!
    @IBOutlet var firstPlayerTurnLabel: UILabel!
    @IBOutlet var secondPlayerTurnLabel: UILabel!
    @IBOutlet var winnerLabel: UILabel!
    @IBOutlet var restartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabelText()
        
        setFirstState()
        
        gameboardView.onSelectPosition = { [weak self] position in
            guard let self = self else { return }

            self.currentState.addMark(at: position)
            if self.currentState.isMoveCompleted {
                
                self.counter += 1
                
                self.setNextState()
            }
        }
        
        gameboardView.playOut = {
            self.setNextState()
        }
    }
    
    private func setLabelText() {
        switch Session.shared.strategy.mode {
        case .two:
            title = "Два игрока"
            firstPlayerTurnLabel.text = "1st player"
            secondPlayerTurnLabel.text = "2st player"
        case .one:
            title = "Один игрок"
            firstPlayerTurnLabel.text = "Player"
            secondPlayerTurnLabel.text = "Computer"
        case .blindly:
            title = "Вслепую"
            firstPlayerTurnLabel.text = "1st player"
            secondPlayerTurnLabel.text = "2st player"
        }
    }
    
    @IBAction func restartButtonTapped(_ sender: UIButton) {
        
        Log(action: .restartGame)
    
        gameboardView.clear()
        gameBoard.clear()
        setFirstState()
    }
    
    public func resetCounter() {
        self.counter = 0
    }
    
    public func nextCounter() {
        self.counter += 1
    }
    
    private func setFirstState() {
        counter = 0
        let player = Player.first
        currentState = Session.shared.strategy.state(player: player,
                                      gameViewController: self,
                                      gameBoard: gameBoard,
                                      gameboardView: gameboardView,
                                      markViewPrototype: player.markViewPrototype)
    }
    
    private func setNextState() {
        
        switch Session.shared.strategy.mode {
        case .blindly:
            if counter >= 10, let winner = referee.determineWinner() {
                currentState = GameOverState(winner: winner, gameViewController: self)
                return
            } else if counter >= 10 {
                currentState = GameOverState(winner: nil, gameViewController: self)
                return
            }
        default:
            if let winner = referee.determineWinner() {
                currentState = GameOverState(winner: winner, gameViewController: self)
                return
            }
            if counter >= 9 {
                currentState = GameOverState(winner: nil, gameViewController: self)
                return
            }
        }
        
        if let playerInputState = currentState as? PlayerState {
            let player = playerInputState.player.next
            currentState = Session.shared.strategy.state(player: player,
                                          gameViewController: self,
                                          gameBoard: gameBoard,
                                          gameboardView: gameboardView,
                                          markViewPrototype: player.markViewPrototype)
        }
    }
    
}
