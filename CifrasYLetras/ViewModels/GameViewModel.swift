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
    // Letras
    @Published var selectedLetters: [String] = []
    @Published var userWord: String = ""
    @Published var usedLettersIndices: [Int] = []
    
    // Cifras
    @Published var selectedNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var targetUnits: Int = 0
    @Published var targetTens: Int = 0
    @Published var targetHundreds: Int = 0
    @Published var userSolution: String = ""
    @Published var usedNumbers: [Int] = []
    
    // Otras propiedades
    @Published var timerValue: Int = 60
    @Published var isTimerActive: Bool = false
    @Published var isPaused: Bool = false
    @Published var score: Int = 0
    @Published var currentPhase: GamePhase = .letters
    @Published var roundsCompleted: Int = 0
    
    private var game: GameModel
    private var timer: Timer?
    
    init(game: GameModel) {
        self.game = game
        startNewRound()
    }
    
    func startNewRound() {
        switch currentPhase {
        case .letters:
            resetLettersRound()
        case .numbers:
            resetNumbersRound()
        }
        startTimer()
    }
    
    // Métodos juego Letras
    func selectVowel() {
        if selectedLetters.count < 10 {
            if let randomVowel = game.vowels.randomElement() {
                selectedLetters.append(randomVowel)
            }
        }
        if selectedLetters.count == 10 {
            startTimer()
        }
    }
    
    func selectConsonant() {
        if selectedLetters.count < 10 {
            if let randomConsonant = game.consonants.randomElement() {
                selectedLetters.append(randomConsonant)
            }
        }
        if selectedLetters.count == 10 {
            startTimer()
        }
    }
    
    func startTimer() {
        isTimerActive = true
        isPaused = false
        timerValue = 60
        timer?.invalidate()
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
        isPaused = false
        timer?.invalidate()
        timer = nil
    }
    
    func pauseTimer() {
        isTimerActive = false
        isPaused = true
        timer?.invalidate()
        timer = nil
    }
    
    func resumeTimer() {
        isTimerActive = true
        isPaused = false
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
    
    func resetGame() {
        selectedLetters = []
        userWord = ""
        usedLettersIndices = []
        selectedNumbers = []
        targetNumber = 0
        targetUnits = 0
        targetTens = 0
        targetHundreds = 0
        userSolution = ""
        usedNumbers = []
        timerValue = 60
        isTimerActive = false
        isPaused = false
        score = 0
        currentPhase = .letters
        roundsCompleted = 0
        timer?.invalidate()
        timer = nil
        startNewRound()
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
                resetNumbersRound()
            } else {
                resetLettersRound()
            }
        } else {
            currentPhase = .letters
            resetLettersRound()
        }
        startTimer()
    }
    
    private func resetLettersRound() {
        selectedLetters = []
        userWord = ""
        usedLettersIndices = []
        timerValue = 60
        isTimerActive = false
        isPaused = false
    }
    
    func toggleLetterUsage(at index: Int) {
        let letter = selectedLetters[index]
        if usedLettersIndices.contains(index) {
            usedLettersIndices.removeAll { $0 == index }
            if let range = userWord.range(of: letter) {
                userWord.removeSubrange(range)
            }
        } else {
            usedLettersIndices.append(index)
            userWord.append(letter)
        }
    }
    
    // Métodos juego Cifras
    func selectNumber() {
        if selectedNumbers.count < 6 {
            let allNumbers = Array(1...10) + [25, 50, 75, 100]
            var number: Int
            
            repeat {
                number = allNumbers.randomElement()!
            } while selectedNumbers.contains(number) || (number > 10 && selectedNumbers.filter { $0 > 10 }.count >= 2)
            
            selectedNumbers.append(number)
        }
        if selectedNumbers.count == 6 {
            generateTargetNumber()
            animateTargetNumber()
            startTimer()
        }
    }
    
    func generateTargetNumber() {
        targetNumber = Int.random(in: 100...999)
    }
    
    func animateTargetNumber() {
        let hundreds = targetNumber / 100
        let tens = (targetNumber % 100) / 10
        let units = targetNumber % 10
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.targetHundreds = hundreds
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.targetTens = tens
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.targetUnits = units
        }
    }
    
    func addNumberToSolution(number: Int) {
        if !usedNumbers.contains(number) {
            userSolution += "\(number)"
            usedNumbers.append(number)
            checkAndEvaluatePartialSolution()
        }
    }
    
    func addOperatorToSolution(op: String) {
        userSolution += " \(op) "
    }
    
    func removeLastEntryFromSolution() {
        guard !userSolution.isEmpty else { return }
        let components = userSolution.split(separator: " ")
        if !components.isEmpty {
            let lastComponent = components.last!
            if let lastNumber = Int(lastComponent), let index = usedNumbers.firstIndex(of: lastNumber) {
                usedNumbers.remove(at: index)
            }
            userSolution = components.dropLast().joined(separator: " ")
        }
    }
    
    private func resetNumbersRound() {
        selectedNumbers = []
        targetNumber = 0
        targetUnits = 0
        targetTens = 0
        targetHundreds = 0
        userSolution = ""
        usedNumbers = []
        timerValue = 60
        isTimerActive = false
        isPaused = false
    }
    
    func evaluateSolution() -> Int? {
        let components = userSolution.split(separator: " ")
        guard !components.isEmpty else { return nil }
        
        var result: Int?
        var currentOperator: String?
        
        for component in components {
            if let number = Int(component) {
                if let currentResult = result {
                    switch currentOperator {
                    case "+":
                        result = currentResult + number
                    case "-":
                        result = currentResult - number
                    case "*":
                        result = currentResult * number
                    case "/":
                        result = currentResult / number
                    default:
                        break
                    }
                } else {
                    result = number
                }
            } else {
                currentOperator = String(component)
            }
        }
        
        return result
    }
    
    func checkSolution() -> Bool {
        guard let result = evaluateSolution() else { return false }
        if result == targetNumber {
            score += 10
            return true
        } else if abs(result - targetNumber) <= 10 {
            score += 5
            return true
        }
        return false
    }
    
    func checkAndEvaluatePartialSolution() {
        let components = userSolution.split(separator: " ")
        if components.count == 3 {
            if let result = evaluateSolution() {
                userSolution = "\(result)"
            }
        }
    }
    
    func showFinalSolution() {
        guard let result = evaluateSolution() else { return }
        userSolution += " = \(result)"
    }
}
