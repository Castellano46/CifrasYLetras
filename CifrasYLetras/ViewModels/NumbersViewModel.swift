//
//  NumbersViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 8/7/24.
//

import Foundation

protocol NumbersViewModelDelegate: AnyObject {
    func allNumbersSelected()
}

class NumbersViewModel: ObservableObject {
    @Published var selectedNumbers: [Int] = []
    @Published var targetNumber: Int = 0
    @Published var targetUnits: Int = 0
    @Published var targetTens: Int = 0
    @Published var targetHundreds: Int = 0
    @Published var userSolution: String = ""
    @Published var usedNumbers: [Int] = []
    @Published var intermediateResults: [Int] = Array(repeating: 0, count: 5)
    @Published var finalSolution: Int?
    
    private var game: GameModel
    
    private var firstOperand: Int? = nil
    private var selectedOperator: String? = nil
    private var operations: [(firstOperand: Int, secondOperand: Int, result: Int)] = []
    
    weak var delegate: NumbersViewModelDelegate?
    
    init(game: GameModel) {
        self.game = game
        //resetNumbersRound()
    }
    
    func resetNumbersRound() {
        selectedNumbers = []
        usedNumbers = []
        intermediateResults = []
        targetNumber = 0
        targetHundreds = 0
        targetTens = 0
        targetUnits = 0
        finalSolution = nil
        //
        generateTargetNumber()
        generateSelectedNumbers()
    }
    
    private func generateSelectedNumbers() {
        selectedNumbers = (1...6).map { _ in Int.random(in: 1...9) }
    }
    //
    
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
            delegate?.allNumbersSelected()
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
    
    func resetSolution() {
        userSolution = ""
        usedNumbers = []
        intermediateResults = Array(repeating: 0, count: 5)
        firstOperand = nil
        selectedOperator = nil
        finalSolution = nil
    }
    
    func selectNumberForOperation(number: Int) {
        if usedNumbers.contains(number) { return }
        
        if firstOperand == nil {
            firstOperand = number
            userSolution += "\(number)"
            usedNumbers.append(number)
        } else if let op = selectedOperator {
            userSolution += " \(op) \(number)"
            usedNumbers.append(number)
            performOperation()
            selectedOperator = nil
        }
    }
    
    func addOperatorToSolution(op: String) {
        if firstOperand != nil && selectedOperator == nil {
            selectedOperator = op
            userSolution += " \(op)"
        }
    }
    
    func performOperation() {
        guard let firstOperand = firstOperand,
              let selectedOperator = selectedOperator,
              let secondOperand = userSolution.split(separator: " ").last.flatMap({ Int($0) }) else { return }
        
        var result: Int?
        
        switch selectedOperator {
        case "+":
            result = firstOperand + secondOperand
        case "-":
            result = firstOperand - secondOperand
        case "*":
            result = firstOperand * secondOperand
        case "/":
            result = firstOperand / secondOperand
        default:
            break
        }
        
        if let result = result {
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
            operations.append((firstOperand: firstOperand, secondOperand: secondOperand, result: result))
            self.firstOperand = nil
            self.finalSolution = result
        }
    }
    
    func undoLastOperation() {
        guard let lastOperation = operations.popLast() else { return }
        
        let (firstOperand, secondOperand, result) = lastOperation
        
        if let resultIndex = intermediateResults.firstIndex(of: result) {
            intermediateResults[resultIndex] = 0
        }
        
        usedNumbers.removeAll { $0 == firstOperand || $0 == secondOperand || $0 == result }
        
        let components = userSolution.split(separator: " ")
        if components.count >= 3 {
            userSolution = components.dropLast(3).joined(separator: " ")
        }
        
        if finalSolution == result {
            finalSolution = nil
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
        finalSolution = result
        userSolution += " = \(result)"
    }
}
