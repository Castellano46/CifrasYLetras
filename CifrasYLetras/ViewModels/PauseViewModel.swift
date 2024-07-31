//
//  PauseViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 31/7/24.
//

import Foundation

class PauseViewModel: ObservableObject {
    @Published var gameViewModel: GameViewModel
    
    init(gameViewModel: GameViewModel) {
        self.gameViewModel = gameViewModel
    }
    
    func resumeGame() {
        gameViewModel.resumeTimer()
    }
    
    func replayGame() {
        gameViewModel.resetGame()
    }
    
    func exitToMainMenu() {
        gameViewModel.currentPhase = .mainMenu
        //gameViewModel.resetGame()
        //gameViewModel.showMainMenu = true
    }
}
