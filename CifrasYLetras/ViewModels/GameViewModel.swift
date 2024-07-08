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
    // Otras propiedades
    @Published var timerValue: Int = 60
    @Published var isTimerActive: Bool = false
    @Published var isPaused: Bool = false
    @Published var score: Int = 0
    @Published var currentPhase: GamePhase = .letters
    @Published var roundsCompleted: Int = 0
    
    private var game: GameModel
    private var timer: Timer?
    private var isFirstRound: Bool = true
    
    init(game: GameModel) {
        self.game = game
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
                self.advanceToNextPhase()
            }
        }
    }

    func resetGame() {
        timerValue = 60
        isTimerActive = false
        isPaused = false
        isFirstRound = true
        // No reiniciar el puntaje
        currentPhase = .letters
        roundsCompleted = 0
        timer?.invalidate()
        timer = nil
        startNewRound()
    }

    func advanceToNextPhase() {
        stopTimer()
        if currentPhase == .letters {
            roundsCompleted += 1
            if roundsCompleted % 2 == 0 {
                currentPhase = .numbers
            } else {
                currentPhase = .letters
            }
        } else {
            currentPhase = .letters
        }
        startTimerIfNeeded()
    }
}
