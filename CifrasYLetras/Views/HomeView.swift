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
                
                VStack {
                    
                    NavigationLink(destination: LettersGameView(viewModel: viewModel)) {
                        Text("Inicio")
                            .font(.title)
                            .frame(maxWidth: 170, minHeight: 30)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        // Acción para mostrar puntuaciones
                    }) {
                        Text("Puntuaciones")
                            .font(.title)
                            .frame(maxWidth: 170, minHeight: 30)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
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
