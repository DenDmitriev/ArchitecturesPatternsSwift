//
//  InvokerPositionCommands.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class InvokerPositionCommands {

    var commands: [ Player : [SetPositionCommand] ] = [.first : [], .second : []]
    
    var count: Int {
        return (commands[.first]?.count ?? 0) + (commands[.second]?.count ?? 0)
    }

    public func action(handler: @escaping (() -> Void)) {
        
        var player: Player = .first
        
        for time in 1...10 {
            
            //guard let command = self.commands[player]?.first else { continue }
            
            //self.commands[player]?.remove(at: 0)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(time)) {
                guard let command = self.commands[player]?.first else { return }
                self.commands[player]?.remove(at: 0)
                player = (player == .first) ? .second : .first
                command.execute {
                    if self.count == 0 {
                        handler()
                    }
                }
            }
            
            //player = (player == .first) ? .second : .first
        }
    }
    
}
