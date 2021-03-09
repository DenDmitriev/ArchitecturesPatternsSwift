//
//  GameModeStrategy.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol GameModeStrategy {
    var mode: GameMode { get }
    
    func next(previous: Player) -> Player
    
    func state(player: Player,
                  gameViewController: GameViewController,
                  gameBoard: Gameboard,
                  gameboardView: GameboardView,
                  markViewPrototype: MarkView) -> GameState
}
