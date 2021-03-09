//
//  PlayerState.swift
//  XO-game
//
//  Created by Evgenii Semenov on 27.02.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class PlayerState: GameState {

    public var isMoveCompleted: Bool = false
    
    public let player: Player
    public weak var gameViewController: GameViewController?
    public weak var gameBoard: Gameboard?
    public weak var gameBoardView: GameboardView?
    
    public var markViewPrototype: MarkView
    
    init(player: Player, gameViewController: GameViewController, gameBoard: Gameboard, gameBoardView: GameboardView, markViewPrototype: MarkView) {
        self.player = player
        self.gameViewController = gameViewController
        self.gameBoard = gameBoard
        self.gameBoardView = gameBoardView
        self.markViewPrototype = markViewPrototype
    }
    
    func begin() {
        switch player {
        case .first:
            gameViewController?.firstPlayerTurnLabel.isHidden = false
            gameViewController?.secondPlayerTurnLabel.isHidden = true
        case .second:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        case .computer:
            gameViewController?.firstPlayerTurnLabel.isHidden = true
            gameViewController?.secondPlayerTurnLabel.isHidden = false
        }
        
        gameViewController?.winnerLabel.isHidden = true
    }
    
    func addMark(at position: GameboardPosition) {
        
        guard let gameBoardView = gameBoardView, gameBoardView.canPlaceMarkView(at: position) else {
            return
        }
        
        Log(action: .playerSetMark(player: player, position: position))
        
        gameBoard?.setPlayer(player, at: position)
        
        gameBoardView.placeMarkView(markViewPrototype.copy(), at: position)
        
        isMoveCompleted = true
    }
}
