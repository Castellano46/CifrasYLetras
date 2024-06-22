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
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 5)
                
                Button(action: viewModel.selectConsonant) {
                    Text("Consonante")
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding(.horizontal, 5)
            }
            .frame(height: 50)
            .padding()
            
            VStack(spacing: 30) {
                ForEach(0..<2) { row in
                    HStack(spacing: 20) {
                        ForEach(0..<5) { col in
                            let index = row * 5 + col
                            GeometryReader { geometry in
                                if index < viewModel.selectedLetters.count {
                                    Text(viewModel.selectedLetters[index])
                                        .font(.largeTitle)
                                        .frame(width: geometry.size.width, height: geometry.size.width)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(8)
                                } else {
                                    Text(" ")
                                        .font(.largeTitle)
                                        .frame(width: geometry.size.width, height: geometry.size.width)
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(8)
                                }
                            }
                        }
                    }
                }
            }
            .frame(height: 100)
            .padding()
            
            Text("Tiempo: \(viewModel.timerValue) segundos")
                .font(.title)
                .padding()
            
            TextField("Tu palabra", text: $viewModel.userWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
                .disabled(!viewModel.isTimerActive)
            
            if viewModel.isTimerActive {
                HStack {
                    Button(action: viewModel.pauseTimer) {
                        Image(systemName: "pause.fill")
                            .padding()
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            } else if viewModel.isPaused {
                HStack {
                    Button(action: viewModel.resumeTimer) {
                        Image(systemName: "play.fill")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
            
            Text("Puntuación: \(viewModel.score)")
                .font(.title)
                .padding()
        }
    }
}

struct LettersGameView_Previews: PreviewProvider {
    static var previews: some View {
        LettersGameView(viewModel: GameViewModel(game: GameModel()))
    }
}
