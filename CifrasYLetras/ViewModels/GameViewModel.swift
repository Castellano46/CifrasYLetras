//
//  GameViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    @Published var letters: [String]
    @Published var targetNumber: Int
    @Published var availableNumbers: [Int]
    @Published var userWord: String = ""
    @Published var userSolution: [Int] = []
    
    init(game: GameModel) {
        self.letters = game.letters
        self.targetNumber = game.targetNumber
        self.availableNumbers = game.availableNumbers
    }
    
    func checkWord() -> Bool {
        return true
    }
    
    func checkSolution() -> Bool {
        return true
    }
}

