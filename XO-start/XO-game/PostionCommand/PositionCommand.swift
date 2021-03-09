//
//  PositionCommand.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

protocol PositionCommand {
    func execute(handler: (() -> Void)?)
}
