//
//  NumbersViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 8/7/24.
//

import Foundation
import SwiftUI

class NumbersViewModel: ObservableObject {
    @Published var selectedNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var targetUnits: Int = 0
    @Published var targetTens: Int = 0
    @Published var targetHundreds: Int = 0
    @Published var userSolution: String = ""
    @Published var usedNumbers: [Int] = []
    @Published var intermediateResults: [Int] = Array(repeating: 0, count: 4)

    private var game: GameModel

    init(game: GameModel) {
        self.game = game
    }

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
    
    func resetNumbersRound() {
        selectedNumbers = []
        targetNumber = 0
        targetUnits = 0
        targetTens = 0
        targetHundreds = 0
        userSolution = ""
        usedNumbers = []
        intermediateResults = Array(repeating: 0, count: 4)
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
            if let lastNumber = Int(lastComponent) {
                if let index = usedNumbers.firstIndex(of: lastNumber) {
                    usedNumbers.remove(at: index)
                }
            }
            userSolution = components.dropLast().joined(separator: " ")
        }
    }

    func evaluateSolution() -> Int? {
        let components = userSolution.split(separator: " ")
        guard !components.isEmpty else { return nil }
        
        var result: Int?
        var currentOperator: String?
        
        for component in components {
            if let number = Int(component) {
                if let op = currentOperator {
                    switch op {
                    case "+":
                        result = (result ?? 0) + number
                    case "-":
                        result = (result ?? 0) - number
                    case "*":
                        result = (result ?? 0) * number
                    case "/":
                        result = (result ?? 0) / number
                    default:
                        break
                    }
                    currentOperator = nil
                } else {
                    result = number
                }
            } else {
                currentOperator = String(component)
            }
        }
        return result
    }
    
    func checkAndEvaluatePartialSolution() {
        if let result = evaluateSolution() {
            for i in 0..<intermediateResults.count {
                if intermediateResults[i] == 0 {
                    intermediateResults[i] = result
                    break
                }
            }
            if result == targetNumber {
                // Realizar acción cuando se obtiene el resultado correcto
                print("¡Solución correcta!")
            }
        }
    }
    
    func showFinalSolution() {
        guard let result = evaluateSolution() else { return }
        userSolution += " = \(result)"
    }
}
