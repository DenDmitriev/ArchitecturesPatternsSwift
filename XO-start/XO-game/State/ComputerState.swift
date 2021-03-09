//
//  ComputerState.swift
//  XO-game
//
//  Created by Denis Dmitriev on 09.03.2021.
//  Copyright © 2021 plasmon. All rights reserved.
//

import Foundation

class ComputerState: PlayerState {
    
    override func begin() {
        super.begin()

        computerRun()
    }
    
    private func computerRun() {
        guard let gameBoardView = gameBoardView else { return }
        let freePostions = gameBoardView.freePlaceMarkView()
        guard let position = freePostions.randomElement() else { return }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            gameBoardView.onSelectPosition?(position)
        }
        
    }
}
