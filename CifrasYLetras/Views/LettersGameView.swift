//
//  LettersGameView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct LettersGameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Letras")
                .font(.largeTitle)
                .padding()
            
            HStack {
                Button(action: viewModel.selectVowel) {
                    Text("Vocal")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: viewModel.selectConsonant) {
                    Text("Consonante")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
            
            HStack {
                ForEach(viewModel.selectedLetters, id: \.self) { letter in
                    Text(letter)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding()
            
            Text("Tiempo restante: \(viewModel.timerValue) segundos")
                .font(.title)
                .padding()
            
            TextField("Tu palabra", text: $viewModel.userWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(!viewModel.isTimerActive)
            
            if !viewModel.isTimerActive && viewModel.selectedLetters.count == 10 {
                Button(action: viewModel.startTimer) {
                    Text("Empezar")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
            
            if viewModel.isTimerActive {
                Button(action: viewModel.stopTimer) {
                    Text("Detener")
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

struct LettersGameView_Previews: PreviewProvider {
    static var previews: some View {
        LettersGameView(viewModel: GameViewModel(game: GameModel()))
    }
}

