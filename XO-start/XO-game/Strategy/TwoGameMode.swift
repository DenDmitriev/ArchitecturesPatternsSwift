//
//  TwoGameMode.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class TwoGameMode: GameModeStrategy {
    
    var mode: GameMode = .two
    
    func next(previous: Player) -> Player {
        return previous == .first ? .second : .first
    }
    
    func state(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameboardView: GameboardView, markViewPrototype: MarkView) -> GameState {
        return PlayerState(player: player, gameViewController: gameViewController, gameBoard: gameBoard, gameBoardView: gameboardView, markViewPrototype: markViewPrototype)
    }
}
