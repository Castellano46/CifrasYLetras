//
//  LettersViewModel.swift
//  CifrasYLetras
//
//  Created by Pedro on 8/7/24.
//

import Foundation
import SwiftUI

class LettersViewModel: ObservableObject {
    @Published var selectedLetters: [String] = []
    @Published var userWord: String = ""
    @Published var usedLettersIndices: [Int] = []
    
    private var game: GameModel

    init(game: GameModel) {
        self.game = game
    }
    
    func selectVowel() {
        guard selectedLetters.count < 10 else { return }
        
        if selectedLetters.count < 10 {
            if let randomVowel = game.vowels.randomElement() {
                selectedLetters.append(randomVowel)
            }
        }
    }
    
    func selectConsonant() {
        guard selectedLetters.count < 10 else { return }
        
        if selectedLetters.count < 10 {
            if let randomConsonant = game.consonants.randomElement() {
                selectedLetters.append(randomConsonant)
            }
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

    private func calculateScore() -> Int {
        let isValid = isValidWord(word: userWord)
        if isValid {
            return userWord.count
        }
        return 0
    }
}
