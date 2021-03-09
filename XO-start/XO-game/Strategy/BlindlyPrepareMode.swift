//
//  BlindlyPrepareMode.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation


class BlindlyPrepareMode: GameModeStrategy {
    
    var mode: GameMode = .blindly
    
    func next(previous: Player) -> Player {
        return previous == .first ? .second : .first
    }
    
    func state(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) -> GameState {
        
        if Session.shared.invoker.count == BlindlyPrepareState.count * 2 {
            
            gameViewController.resetCounter()
            
            return BlindlyGameState(player: player,
                                    gameViewController: gameViewController,
                                    gameBoard: gameBoard,
                                    gameBoardView: gameboardView,
                                    markViewPrototype: markViewPrototype)
        }
        
        return BlindlyPrepareState(player: player,
                            gameViewController: gameViewController,
                            gameBoard: gameBoard,
                            gameBoardView: gameboardView,
                            markViewPrototype: markViewPrototype)
    }
}
