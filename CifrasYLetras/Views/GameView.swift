//
//  GameView.swift
//  CifrasYLetras
//
//  Created by Pedro on 31/7/24.
//

import SwiftUI

struct GameView: View {
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var lettersViewModel: LettersViewModel
    @ObservedObject var numbersViewModel: NumbersViewModel
    
    var body: some View {
        Group {
            switch viewModel.currentPhase {
            case .letters:
                LettersGameView(lettersViewModel: lettersViewModel, gameViewModel: viewModel)
            case .numbers:
                NumbersGameView(numbersViewModel: numbersViewModel, gameViewModel: viewModel)
            case .paused:
                PauseView(pauseViewModel: PauseViewModel(gameViewModel: viewModel))
            case .mainMenu:
                HomeView(viewModel: viewModel, lettersViewModel: lettersViewModel, numbersViewModel: numbersViewModel)
            }
        }
    }
}
