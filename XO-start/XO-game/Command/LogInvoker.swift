//
//  LogInvoker.swift
//  XO-game
//
//  Created by Evgenii Semenov on 27.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class LogInvoker {
    
    static let shared = LogInvoker()
    private init() {}
    
    private let receiver = LogReceiver()
    private var bufferSize = 5
    
    private var commands = [LogCommand]()
    
    func addLogCommand(command: LogCommand) {
        
        commands.append(command)
        execute()
    }
    
    func execute() {
        guard commands.count >= bufferSize else { return }
        
        commands.forEach {
            receiver.sendMessageToServerLog(message: $0.logMessage)
        }
        
        commands.removeAll()
    }
    
}
