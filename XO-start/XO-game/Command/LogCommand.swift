//
//  LogCommand.swift
//  XO-game
//
//  Created by Evgenii Semenov on 27.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class LogCommand {
    
    let action: LogAction
    
    init(action: LogAction) {
        self.action = action
    }
    
    var logMessage: String {
        switch action {
        case let .gameFinished(winner: winner):
            if let winner = winner {
                return "\(winner) won game"
            } else {
                return "Is draw"
            }
            
        case let .playerSetMark(player: player, position: position):
            return "\(player) placed mark at \(position)"
            
        case .restartGame:
            return "Game restarted"
        }
    }
}
