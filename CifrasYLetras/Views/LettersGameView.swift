//
//  LettersGameView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct LettersGameView: View {
    @ObservedObject var lettersViewModel: LettersViewModel
    @ObservedObject var gameViewModel: GameViewModel

    init(lettersViewModel: LettersViewModel, gameViewModel: GameViewModel) {
        self.lettersViewModel = lettersViewModel
        self.gameViewModel = gameViewModel
        self.lettersViewModel.delegate = gameViewModel
        self.gameViewModel.lettersViewModel = lettersViewModel
    }

    var body: some View {
        ZStack {
            Image("letras")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Button(action: lettersViewModel.selectVowel) {
                        RealisticButton(color: .purple, iconName: "v.circle")
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 20)
                    .disabled(lettersViewModel.selectedLetters.count >= 10 || gameViewModel.isPaused)

                    Button(action: lettersViewModel.selectConsonant) {
                        RealisticButton(color: .cyan, iconName: "c.circle")
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 20)
                    .disabled(lettersViewModel.selectedLetters.count >= 10 || gameViewModel.isPaused)
                }
                .frame(height: 80)
                .padding()

                VStack(spacing: 30) {
                    ForEach(0..<2) { row in
                        HStack(spacing: 20) {
                            ForEach(0..<5) { col in
                                let index = row * 5 + col
                                GeometryReader { geometry in
                                    if index < lettersViewModel.selectedLetters.count {
                                        Text(lettersViewModel.selectedLetters[index])
                                            .font(.largeTitle)
                                            .frame(width: geometry.size.width, height: geometry.size.width)
                                            .background(lettersViewModel.usedLettersIndices.contains(index) ? Color.red.opacity(0.8) : Color.gray.opacity(0.8))
                                            .border(Color.pink, width: 2)
                                            .cornerRadius(15)
                                            .onTapGesture {
                                                lettersViewModel.toggleLetterUsage(at: index)
                                            }
                                            .disabled(gameViewModel.isPaused)
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

                Text(lettersViewModel.userWord)
                    .font(.title)
                    .padding()
                    .frame(width: 300, height: 50)
                    .fixedSize(horizontal: true, vertical: false)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                    .padding()

                Text("Tiempo: \(gameViewModel.timerValue) segundos")
                    .font(.title)
                    .padding()

                if gameViewModel.isTimerActive {
                    HStack {
                        Button(action: gameViewModel.pauseTimer) {
                            Image(systemName: "pause.fill")
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                } else if gameViewModel.isPaused {
                    HStack {
                        Button(action: gameViewModel.resumeTimer) {
                            Image(systemName: "play.fill")
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                }

                Text("Puntuación: \(gameViewModel.score)")
                    .font(.title)
                    .padding()
            }
            .onAppear {
                gameViewModel.resetGame()
            }
        }
    }
}

struct LettersGameView_Previews: PreviewProvider {
    static var previews: some View {
        LettersGameView(lettersViewModel: LettersViewModel(game: GameModel()), gameViewModel: GameViewModel(game: GameModel()))
    }
}
