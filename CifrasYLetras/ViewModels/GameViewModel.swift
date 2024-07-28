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

class GameViewModel: ObservableObject, LettersViewModelDelegate, NumbersViewModelDelegate {
    @Published var timerValue: Int = 40
    @Published var isTimerActive: Bool = false
    @Published var isPaused: Bool = false
    @Published var score: Int = 0
    @Published var currentPhase: GamePhase = .letters
    @Published var roundsCompleted: Int = 0
    @Published var roundCounter: Int = 1
    @Published var showMainMenu: Bool = false
    
    private var game: GameModel
    private var timer: Timer?
    private var isFirstRound: Bool = true
    var lettersViewModel: LettersViewModel?
    var numbersViewModel: NumbersViewModel?
    
    init(game: GameModel) {
        self.game = game
        self.lettersViewModel = LettersViewModel(game: game)
        self.lettersViewModel?.delegate = self
        self.numbersViewModel = NumbersViewModel(game: game)
        self.numbersViewModel?.delegate = self
        startNewRound()
    }
    
    func startNewRound() {
        if !isFirstRound {
            startTimerIfNeeded()
        }
    }
    
    func startTimerIfNeeded() {
        if isFirstRound {
            isFirstRound = false
        }
        startTimer()
    }
    
    func startTimer() {
        timerValue = 40
        isTimerActive = true
        isPaused = false
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.timerValue > 0 {
                self.timerValue -= 1
            } else {
                self.stopTimer()
                self.updateScore()
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
                self.updateScore()
                self.advanceToNextPhase()
            }
        }
    }
    
    func resetGame() {
        timerValue = 40
        isTimerActive = false
        isPaused = false
        isFirstRound = true
        currentPhase = .letters
        roundsCompleted = 0
        roundCounter = 1
        showMainMenu = false
        timer?.invalidate()
        timer = nil
        lettersViewModel?.resetLettersRound()
        numbersViewModel?.resetNumbersRound()
        startNewRound()
    }
    
    func advanceToNextPhase() {
        stopTimer()
        if currentPhase == .letters {
            roundsCompleted += 1
            roundCounter += 1
            lettersViewModel?.resetLettersRound()
            if roundsCompleted % 2 == 0 {
                currentPhase = .numbers
                numbersViewModel?.resetNumbersRound()
            } else {
                currentPhase = .letters
            }
        } else {
            currentPhase = .letters
            numbersViewModel?.resetNumbersRound()
        }
    }
    
    func allLettersSelected() {
        startTimer()
    }
    
    func allNumbersSelected() {
        startTimer()
    }
    
    private func updateScore() {
        if currentPhase == .letters {
            if let lettersViewModel = lettersViewModel {
                score += lettersViewModel.calculateScore()
            }
        }
        // Agrega la lógica para actualizar la puntuación en la fase de números si es necesario.
    }
}
