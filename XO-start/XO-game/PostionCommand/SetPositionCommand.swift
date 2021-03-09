//
//  SetPositionCommand.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

struct SetPositionCommand: PositionCommand {
    
    let player: Player
    let position: GameboardPosition
    let gameViewController: GameViewController
    let gameBoardView: GameboardView
    let gameBoard: Gameboard
    let markViewPrototype: MarkView
    
    func execute(handler: (() -> Void)?) {
        
        switch player {
        case .first:
            gameViewController.firstPlayerTurnLabel.isHidden = false
            gameViewController.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController.secondPlayerTurnLabel.isHidden = false
            gameViewController.firstPlayerTurnLabel.isHidden = true
        default:
            break
        }
        
        if !gameBoardView.canPlaceMarkView(at: position) {
            gameBoardView.removeMarkView(at: position)
            gameBoard.clear(at: position)
        }
        
        gameViewController.nextCounter()
        
        Log(action: .playerSetMark(player: player, position: position))
        
        gameBoard.setPlayer(player, at: position)
        
        gameBoardView.placeMarkView(markViewPrototype, at: position)
        
        handler?()
    }
    
}
