//
//  ContentView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel(game: GameModel())
    
    var body: some View {
        NavigationView {
            VStack {
                LettersGameView(viewModel: viewModel)
                Divider()
                NumbersGameView(viewModel: viewModel)
            }
            .navigationTitle("Cifras y Letras")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
