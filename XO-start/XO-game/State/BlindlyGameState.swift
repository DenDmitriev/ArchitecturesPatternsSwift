//
//  BlindlyGameState.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class BlindlyGameState: PlayerState {
    
    
    override func begin() {
        super.begin()
        
        gameViewController?.winnerLabel.isHidden = false
        gameViewController?.winnerLabel.text = "Playing"
        
        play()
    }
    
    fileprivate func play() {
        Session.shared.invoker.action {
            guard let gameBoardView = self.gameBoardView else { return }
            gameBoardView.playOut?()
        }
    }
    
    override func addMark(at position: GameboardPosition) {}
    
}
