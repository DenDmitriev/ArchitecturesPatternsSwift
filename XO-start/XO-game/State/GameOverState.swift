//
//  GameOverState.swift
//  XO-game
//
//  Created by Evgenii Semenov on 27.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class GameOverState: GameState {

    var isMoveCompleted = false

    public let winner: Player?
    private weak var gameViewController: GameViewController?

    init(winner: Player?, gameViewController: GameViewController) {
        self.winner = winner
        self.gameViewController = gameViewController
    }


    func begin() {
        gameViewController?.winnerLabel.isHidden = false
        
        if let winner = winner {
            gameViewController?.winnerLabel.text = getWinnerName(from: winner)
        } else {
            gameViewController?.winnerLabel.text = "No winner"
        }
        
        gameViewController?.firstPlayerTurnLabel.isHidden = true
        gameViewController?.secondPlayerTurnLabel.isHidden = true
        
        Log(action: .gameFinished(winner: winner))
    }

    func addMark(at position: GameboardPosition) {}
    
    private func getWinnerName(from winner: Player) -> String {
        switch winner {
        case .first:
            return "1st player won"
        case .second:
            return "2nd player won"
        case .computer:
            return "You lose"
        }
    }
}
