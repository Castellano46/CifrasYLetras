//
//  NumbersGameView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct NumbersGameView: View {
    @ObservedObject var numbersViewModel: NumbersViewModel
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Image("cifras")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack {
                    Text("Cifras")
                        .font(.largeTitle)
                        .padding(.top)
                    
                    if gameViewModel.timerValue > 0 {
                        Text("Tiempo: \(gameViewModel.timerValue)")
                            .font(.title)
                            .padding()
                    }
                    
                    Button(action: numbersViewModel.selectNumber) {
                        Text("Número")
                            .frame(width: 150, height: 50)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    .disabled(numbersViewModel.selectedNumbers.count == 6)
                    
                    HStack {
                        ForEach(0..<6) { index in
                            if index < numbersViewModel.selectedNumbers.count {
                                NumberSlotView(number: numbersViewModel.selectedNumbers[index], isUsed: numbersViewModel.usedNumbers.contains(numbersViewModel.selectedNumbers[index]))
                                    .onTapGesture {
                                        numbersViewModel.addNumberToSolution(number: numbersViewModel.selectedNumbers[index])
                                    }
                            } else {
                                NumberSlotView(number: 0, isUsed: false)
                            }
                        }
                    }
                    .padding()
                    
                    HStack {
                        NumberSlotView(number: numbersViewModel.targetHundreds, isUsed: false)
                        NumberSlotView(number: numbersViewModel.targetTens, isUsed: false)
                        NumberSlotView(number: numbersViewModel.targetUnits, isUsed: false)
                    }
                    .padding()
                    
                    HStack {
                        ForEach(0..<4) { index in
                            ResultSlotView(number: numbersViewModel.intermediateResults[index])
                                .frame(width: 70, height: 70)
                                .padding(.horizontal, 5)
                        }
                    }
                    .padding()
                    
                    if gameViewModel.isTimerActive {
                        Button(action: gameViewModel.pauseTimer) {
                            Image(systemName: "pause.fill")
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    } else if gameViewModel.isPaused {
                        Button(action: gameViewModel.resumeTimer) {
                            Image(systemName: "play.fill")
                                .padding()
                                .background(Color.orange)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                    
                    VStack {
                        HStack {
                            Button(action: {
                                numbersViewModel.addOperatorToSolution(op: "+")
                            }) {
                                Text("+")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray.opacity(0.8))
                                    .border(Color.pink, width: 2)
                                    .cornerRadius(25)
                            }
                            
                            Button(action: {
                                numbersViewModel.addOperatorToSolution(op: "-")
                            }) {
                                Text("-")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray.opacity(0.8))
                                    .border(Color.pink, width: 2)
                                    .cornerRadius(25)
                            }
                            
                            Button(action: {
                                numbersViewModel.addOperatorToSolution(op: "*")
                            }) {
                                Text("x")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray.opacity(0.8))
                                    .border(Color.pink, width: 2)
                                    .cornerRadius(25)
                            }
                            
                            Button(action: {
                                numbersViewModel.addOperatorToSolution(op: "/")
                            }) {
                                Text("/")
                                    .font(.title)
                                    .frame(width: 50, height: 50)
                                    .background(Color.gray.opacity(0.8))
                                    .border(Color.pink, width: 2)
                                    .cornerRadius(25)
                            }
                        }
                        .padding()
                        
                        HStack {
                            Button(action: numbersViewModel.removeLastEntryFromSolution) {
                                Text("Borrar")
                                    .padding()
                                    .background(Color.red)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                            
                            Button(action: {
                                numbersViewModel.showFinalSolution()
                            }) {
                                Text("Comprobar solución")
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(8)
                            }
                        }
                        .padding(.bottom)
                    }
                }
                .padding()
            }
        }
    }
}

struct NumberSlotView: View {
    var number: Int
    var isUsed: Bool
    
    var body: some View {
        Text(number == 0 ? "" : "\(number)")
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .background(Color.yellow.opacity(0.8))
            .border(Color.pink, width: 2)
            .cornerRadius(8)
    }
}

struct ResultSlotView: View {
    var number: Int
    
    var body: some View {
        Text(number == 0 ? "" : "\(number)")
            .font(.largeTitle)
            .frame(width: 70, height: 70)
            .background(Color.yellow.opacity(0.8))
            .border(Color.pink, width: 2)
            .cornerRadius(8)
    }
}

struct NumbersGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGameView(numbersViewModel: NumbersViewModel(game: GameModel()), gameViewModel: GameViewModel(game: GameModel()))
    }
}
