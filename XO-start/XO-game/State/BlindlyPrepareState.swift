//
//  BlindlyPrepareState.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class BlindlyPrepareState: PlayerState {
    
    static let count = 5
    
    override func begin() {
        super.begin()
        gameViewController?.winnerLabel.isHidden = false
        gameViewController?.winnerLabel.text = "Please, put 5 moves"
    }
    
    override func addMark(at position: GameboardPosition) {
        
        guard
            let gameBoardView = gameBoardView,
            gameBoardView.canPlaceMarkView(at: position),
            let gameBoard = gameBoard
        else {
            return
        }
        
        Log(action: .playerSetMark(player: player, position: position))
        
        gameBoard.setPlayer(player, at: position)
        
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        
        let setPositionCommand = SetPositionCommand(player: player, position: position, gameViewController: gameViewController!, gameBoardView: gameBoardView, gameBoard: gameBoard, markViewPrototype: markViewPrototype.copy())

        Session.shared.invoker.commands[player]?.append(setPositionCommand)
        
        guard Session.shared.invoker.commands[player]?.count == BlindlyPrepareState.count else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            gameBoardView.clear()
            self.gameBoard?.clear()
        }
        
        isMoveCompleted = true
    }
}
