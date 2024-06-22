//
//  ContentView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = GameViewModel(game: GameModel())
    
    var body: some View {
        VStack {
            if viewModel.currentPhase == .letters {
                LettersGameView(viewModel: viewModel)
            } else {
                NumbersGameView(viewModel: viewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
