//
//  LogFunc.swift
//  XO-game
//
//  Created by Evgenii Semenov on 27.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

func Log(action: LogAction) {
    let command = LogCommand(action: action)
    LogInvoker.shared.addLogCommand(command: command)
}
