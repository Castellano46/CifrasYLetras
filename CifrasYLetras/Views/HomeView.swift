//
//  HomeView.swift
//  CifrasYLetras
//
//  Created by Pedro on 28/6/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: GameViewModel
    @ObservedObject var lettersViewModel: LettersViewModel
    @ObservedObject var numbersViewModel: NumbersViewModel
    
    init(viewModel: GameViewModel, lettersViewModel: LettersViewModel, numbersViewModel: NumbersViewModel) {
        self.viewModel = viewModel
        self.lettersViewModel = lettersViewModel
        self.numbersViewModel = numbersViewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("fondo")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    NavigationLink(destination: GameView(viewModel: viewModel, lettersViewModel: lettersViewModel, numbersViewModel: numbersViewModel)) {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "play.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    NavigationLink(destination: HowToPlayView()) {
                        Circle()
                            .foregroundColor(.teal)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "book.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white)
                            )
                    }
                    
                    Button(action: {
                        // Acción para mostrar puntuaciones
                    }) {
                        Circle()
                            .foregroundColor(.red)
                            .frame(width: 120, height: 120)
                            .overlay(
                                Image(systemName: "trophy.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 80, height: 80)
                                    .foregroundColor(.white)
                            )
                    }
                }
                .padding()
                .opacity(0.9)
            }
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

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
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let gameModel = GameModel()
        let gameViewModel = GameViewModel(game: gameModel)
        let lettersViewModel = LettersViewModel(game: gameModel)
        let numbersViewModel = NumbersViewModel(game: gameModel)
        return HomeView(viewModel: gameViewModel, lettersViewModel: lettersViewModel, numbersViewModel: numbersViewModel)
    }
}
