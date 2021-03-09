//
//  LogAction.swift
//  XO-game
//
//  Created by Evgenii Semenov on 27.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

enum LogAction {
    case playerSetMark(player: Player, position: GameboardPosition)
    case gameFinished(winner: Player?)
    case restartGame
}
