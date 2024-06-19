//
//  GameModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import Foundation

struct GameModel {
    let vowels: [String] = ["A", "E", "I", "O", "U"]
    let consonants: [String] = ["B", "C", "D", "F", "G", "H", "J", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "X", "Y", "Z"]
    
    // Variables para el juego de Cifras
    let smallNumbers: [Int] = Array(1...10)
    let largeNumbers: [Int] = [25, 50, 75, 100]
    let targetNumberRange: ClosedRange<Int> = 100...999
}
