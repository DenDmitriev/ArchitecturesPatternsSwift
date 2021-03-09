//
//  Session.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

final class Session {
    
    static let shared = Session()
    
    var strategy: GameModeStrategy = TwoGameMode()
    
    var invoker: InvokerPositionCommands = InvokerPositionCommands()
    var commands: [Player: [SetPositionCommand]] = [.first:[], .second:[]]
    
    func clear() {
        commands[.first]?.removeAll()
        commands[.second]?.removeAll()
    }
    
}
