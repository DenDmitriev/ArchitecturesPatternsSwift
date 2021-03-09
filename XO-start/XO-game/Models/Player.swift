//
//  Player.swift
//  XO-game
//
//  Created by Evgeny Kireev on 26/02/2019.
//  Copyright © 2019 plasmon. All rights reserved.
//

import Foundation

public enum Player: CaseIterable {
    case first
    case second
    case computer
    
    private var strategy: GameModeStrategy {
        return Session.shared.strategy
    }
    
    var next: Player {
        return strategy.next(previous: self)
    }
    
    var markViewPrototype: MarkView {
        switch self {
        case .first:
            return XView()
        case .second:
            return OView()
        case .computer:
            return OView()
        }
    }
}
