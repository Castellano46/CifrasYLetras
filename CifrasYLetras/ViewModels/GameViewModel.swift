//
//  GameViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import Foundation
import SwiftUI

enum GamePhase {
    case letters
    case numbers
}

class GameViewModel: ObservableObject {
    // Juego Letras
    @Published var selectedLetters: [String] = []
    @Published var userWord: String = ""
    @Published var timerValue: Int = 60
    @Published var isTimerActive: Bool = false
    @Published var score: Int = 0
    
    // Juego Cifras
    @Published var selectedNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var availableNumbers: [Int] = []
    @Published var userSolution: [Int] = []
    
    // Estado del juego
    @Published var currentPhase: GamePhase = .letters
    @Published var roundsCompleted: Int = 0
    
    private var game: GameModel
    private var timer: Timer?
    
    init(game: GameModel) {
        self.game = game
    }
    
    // Métodos para Letras
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
                self.advanceToNextPhase()
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
        roundsCompleted = 0
        score = 0
        currentPhase = .letters
        timer?.invalidate()
        timer = nil
    }
    
    private func calculateScore() {
        let isValid = isValidWord(word: userWord)
        if isValid {
            score += userWord.count
        }
    }
    
    private func isValidWord(word: String) -> Bool {
        var lettersCopy = selectedLetters
        for char in word {
            if let index = lettersCopy.firstIndex(of: String(char).uppercased()) {
                lettersCopy.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
    
    func advanceToNextPhase() {
        if currentPhase == .letters {
            roundsCompleted += 1
            if roundsCompleted % 2 == 0 {
                currentPhase = .numbers
            } else {
                resetLettersRound()
            }
        } else {
            currentPhase = .letters
        }
    }
    
    private func resetLettersRound() {
        selectedLetters = []
        userWord = ""
        timerValue = 60
        isTimerActive = false
    }
    
    // Métodos para Cifras
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
