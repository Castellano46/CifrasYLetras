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
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "clock")
                                .font(.title)
                                .bold()
                                .foregroundColor(.blue)
                                .background(Circle().fill(Color.yellow.opacity(0.9)).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2).frame(width: 50, height: 50))
                            Text("\(gameViewModel.timerValue)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.blue)
                                .padding(.leading, 10)
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 20)

                        HStack {
                            Image(systemName: "star.fill")
                                .font(.title)
                                .bold()
                                .foregroundColor(.yellow)
                                .background(Circle().fill(Color.green.opacity(0.9)).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2).frame(width: 50, height: 50))
                            Text("\(gameViewModel.score)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.yellow)
                                .padding(.leading, 10)
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 20)
                    }
                    .padding(.top, 70)

                    Spacer()

                    VStack {
                        if gameViewModel.isTimerActive {
                            Button(action: gameViewModel.pauseTimer) {
                                Image(systemName: "pause.fill")
                                    .font(.title)
                                    .foregroundColor(.blue)
                                    .padding()
                            }
                        } else if gameViewModel.isPaused {
                            Button(action: gameViewModel.resumeTimer) {
                                Image(systemName: "play.fill")
                                    .font(.title)
                                    .foregroundColor(.green)
                                    .padding()
                            }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.trailing, 10)
                }
                .padding(.horizontal)

                Spacer()

                Text(lettersViewModel.userWord)
                    .font(.title)
                    .padding()
                    .frame(width: 300, height: 50)
                    .fixedSize(horizontal: true, vertical: false)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
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

                Spacer()

                HStack {
                    Button(action: lettersViewModel.selectVowel) {
                        RealisticButton(color: .purple, iconName: "v.circle")
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 40)
                    .disabled(lettersViewModel.selectedLetters.count >= 10 || gameViewModel.isPaused)

                    Button(action: lettersViewModel.selectConsonant) {
                        RealisticButton(color: .cyan, iconName: "c.circle")
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 40)
                    .disabled(lettersViewModel.selectedLetters.count >= 10 || gameViewModel.isPaused)
                }
                .frame(height: 80)
                .padding()

                Spacer(minLength: 50)
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
