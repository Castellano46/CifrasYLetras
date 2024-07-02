//
//  HomeView.swift
//  CifrasYLetras
//
//  Created by Pedro on 28/6/24.
//

import SwiftUI

struct HomeView: View {
    @ObservedObject var viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                Image("fondo")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                
                VStack(spacing: 20) {
                    NavigationLink(destination: GameView(viewModel: viewModel)) {
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
    
    var body: some View {
        Group {
            switch viewModel.currentPhase {
            case .letters:
                LettersGameView(viewModel: viewModel)
            case .numbers:
                NumbersGameView(viewModel: viewModel)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GameViewModel(game: GameModel())
        return HomeView(viewModel: viewModel)
    }
}
