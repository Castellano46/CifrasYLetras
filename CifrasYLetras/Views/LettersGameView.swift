//
//  LettersGameView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct LettersGameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    init(viewModel: GameViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            Image("letras")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Letras")
                    .font(.largeTitle)
                    .padding(.top)
                
                HStack {
                    Button(action: viewModel.selectVowel) {
                        Circle()
                            .foregroundColor(.purple)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "v.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.horizontal, 20)
                    .disabled(viewModel.selectedLetters.count >= 10 || viewModel.isPaused)
                    
                    Button(action: viewModel.selectConsonant) {
                        Circle()
                            .foregroundColor(.cyan)
                            .frame(width: 100, height: 100)
                            .overlay(
                                Image(systemName: "c.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                    .foregroundColor(.white)
                            )
                    }
                    .padding(.horizontal, 20)
                    .disabled(viewModel.selectedLetters.count >= 10 || viewModel.isPaused)
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
                                            .background(viewModel.usedLettersIndices.contains(index) ? Color.red.opacity(0.8) : Color.gray.opacity(0.8))
                                            .border(Color.pink, width: 2)
                                            .cornerRadius(15)
                                            .onTapGesture {
                                                viewModel.toggleLetterUsage(at: index)
                                            }
                                            .disabled(viewModel.isPaused)  // Disable interaction if paused
                                    } else {
                                        Text(" ")
                                            .font(.largeTitle)
                                            .frame(width: geometry.size.width, height: geometry.size.width)
                                            .background(Color.gray.opacity(0.8))
                                            .border(Color.pink, width: 2)
                                            .cornerRadius(15)
                                    }
                                }
                            }
                        }
                    }
                }
                .frame(height: 100)
                .padding()
                
                Text(viewModel.userWord)
                    .font(.title)
                    .padding()
                    .frame(width: 300, height: 50)
                    .fixedSize(horizontal: true, vertical: false)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding()
                
                Text("Tiempo: \(viewModel.timerValue) segundos")
                    .font(.title)
                    .padding()
                
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
            .onAppear {
                viewModel.resetGame()
            }
        }
    }
}

struct LettersGameView_Previews: PreviewProvider {
    static var previews: some View {
        LettersGameView(viewModel: GameViewModel(game: GameModel()))
    }
}
