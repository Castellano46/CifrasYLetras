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
                    NavigationLink(destination: GameView(viewModel: viewModel, lettersViewModel: lettersViewModel, numbersViewModel: numbersViewModel)
                        .onAppear {
                            viewModel.resetGame()
                        }) {
                            RealisticButton(color: .green, iconName: "play.circle.fill")
                        }
                    
                    NavigationLink(destination: HowToPlayView()) {
                        RealisticButton(color: .teal, iconName: "book.circle.fill")
                    }
                    
                    Button(action: {
                        // Acción para mostrar puntuaciones
                    }) {
                        RealisticButton(color: .red, iconName: "trophy.circle.fill")
                    }
                }
                .padding()
                .opacity(1)
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
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
