//
//  OneGameMode.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class OneGameMode: GameModeStrategy {
    
    var mode: GameMode = .one
    
    func next(previous: Player) -> Player {
        return previous == .first ? .computer : .first
    }
    
    func state(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) -> GameState {
        switch player {
        case .computer:
            return ComputerState(player: player,
                                         gameViewController: gameViewController,
                                         gameBoard: gameBoard,
                                         gameBoardView: gameboardView,
                                         markViewPrototype: player.markViewPrototype)
        default:
            return PlayerState(player: player,
                                       gameViewController: gameViewController,
                                       gameBoard: gameBoard,
                                       gameBoardView: gameboardView,
                                       markViewPrototype: player.markViewPrototype)
        }
    }

}
