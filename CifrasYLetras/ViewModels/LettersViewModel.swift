//
//  LettersViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 8/7/24.
//

import Foundation
import SwiftUI

protocol LettersViewModelDelegate: AnyObject {
    func allLettersSelected()
}

class LettersViewModel: ObservableObject {
    @Published var selectedLetters: [String] = []
    @Published var userWord: String = ""
    @Published var usedLettersIndices: [Int] = []
    
    weak var delegate: LettersViewModelDelegate?
    
    private var game: GameModel
    
    init(game: GameModel) {
        self.game = game
    }
    
    func selectVowel() {
        guard selectedLetters.count < 10 else { return }
        if let randomVowel = game.vowels.randomElement() {
            selectedLetters.append(randomVowel)
        }
        checkIfAllLettersSelected()
    }
    
    func selectConsonant() {
        guard selectedLetters.count < 10 else { return }
        if let randomConsonant = game.consonants.randomElement() {
            selectedLetters.append(randomConsonant)
        }
        checkIfAllLettersSelected()
    }
    
    private func checkIfAllLettersSelected() {
        if selectedLetters.count == 10 {
            delegate?.allLettersSelected()
        }
    }
    
    func resetLettersRound() {
        selectedLetters = []
        userWord = ""
        usedLettersIndices = []
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
    
    func calculateScore() -> Int {
        return isValidWord(word: userWord) ? userWord.count : 0
    }
    
    private func isValidWord(word: String) -> Bool {
        var lettersCopy = selectedLetters
        for char in word.uppercased() {
            if let index = lettersCopy.firstIndex(of: String(char)) {
                lettersCopy.remove(at: index)
            } else {
                return false
            }
        }
        return true
    }
}
