//
//  GameViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import Foundation
import SwiftUI

class GameViewModel: ObservableObject {
    // Juego de Letras
    @Published var selectedLetters: [String] = []
    @Published var userWord: String = ""
    @Published var timerValue: Int = 60
    @Published var isTimerActive: Bool = false
    
    // Juego de Números
    @Published var selectedNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var availableNumbers: [Int] = []
    @Published var userSolution: [Int] = []
    
    private var game: GameModel
    private var timer: Timer?
    
    init(game: GameModel) {
        self.game = game
    }
    
    // Juego de letras
    func selectVowel() {
        if selectedLetters.count < 10 {
            if let randomVowel = game.vowels.randomElement() {
                selectedLetters.append(randomVowel)
            }
        }
    }
    
    func selectConsonant() {
        if selectedLetters.count < 10 {
            if let randomConsonant = game.consonants.randomElement() {
                selectedLetters.append(randomConsonant)
            }
        }
    }
    
    func startTimer() {
        isTimerActive = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
            } else {
                self.stopTimer()
                self.calculateScore()
            }
        }
    }
    
    func stopTimer() {
        isTimerActive = false
        timer?.invalidate()
        timer = nil
    }
    
    func resetGame() {
        selectedLetters = []
        userWord = ""
        timerValue = 60
        isTimerActive = false
        timer?.invalidate()
        timer = nil
    }
    
    private func calculateScore() {
        let score = userWord.count
        print("Puntuación: \(score)")
    }
    
    // MJuego de Cifras
    func selectSmallNumber() {
        if selectedNumbers.count < 6 {
            if let randomSmallNumber = game.smallNumbers.randomElement() {
                selectedNumbers.append(randomSmallNumber)
            }
        }
    }
    
    func selectLargeNumber() {
        if selectedNumbers.count < 6 {
            if let randomLargeNumber = game.largeNumbers.randomElement() {
                selectedNumbers.append(randomLargeNumber)
            }
        }
    }
    
    func generateTargetNumber() {
        targetNumber = Int.random(in: game.targetNumberRange)
    }
    
    func startNumbersGame() {
        availableNumbers = selectedNumbers
        generateTargetNumber()
    }
    
    func checkSolution() -> Bool {
        return true
    }
}
