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
                            GeometryReader { geometry in
                                if index < numbersViewModel.selectedNumbers.count {
                                    NumberSlotView(number: numbersViewModel.selectedNumbers[index], isUsed: numbersViewModel.usedNumbers.contains(numbersViewModel.selectedNumbers[index]))
                                        .onTapGesture {
                                            numbersViewModel.selectNumberForOperation(number: numbersViewModel.selectedNumbers[index])
                                        }
                                } else {
                                    Rectangle()
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .foregroundColor(Color.gray.opacity(0.8))
                                        .border(Color.pink, width: 2)
                                        .cornerRadius(8)
                                }
                            }
                            .frame(width: 50, height: 50)
                            .padding(.horizontal, 5)
                        }
                    }
                    .padding()

                    HStack {
                        TargetNumberSlotView(number: numbersViewModel.targetHundreds)
                        TargetNumberSlotView(number: numbersViewModel.targetTens)
                        TargetNumberSlotView(number: numbersViewModel.targetUnits)
                    }
                    .padding()

                    HStack {
                        ForEach(0..<5) { index in
                            NumberSlotView(number: numbersViewModel.intermediateResults.count > index ? numbersViewModel.intermediateResults[index] : 0, isUsed: numbersViewModel.usedNumbers.contains(numbersViewModel.intermediateResults.count > index ? numbersViewModel.intermediateResults[index] : 0), color: .blue)
                                .frame(width: 70, height: 70)
                                .padding(.horizontal, 5)
                                .onTapGesture {
                                    if numbersViewModel.intermediateResults.count > index {
                                        numbersViewModel.selectNumberForOperation(number: numbersViewModel.intermediateResults[index])
                                    }
                                }
                        }
                    }
                    .padding()

                    if let finalSolution = numbersViewModel.finalSolution {
                        Text("Solución Final: \(finalSolution)")
                            .font(.title)
                            .foregroundColor(finalSolution == numbersViewModel.targetNumber ? .green : .red)
                            .padding()
                    }

                    HStack {
                        OperatorButton(op: "+", action: {
                            numbersViewModel.addOperatorToSolution(op: "+")
                        })
                        OperatorButton(op: "-", action: {
                            numbersViewModel.addOperatorToSolution(op: "-")
                        })
                        OperatorButton(op: "*", action: {
                            numbersViewModel.addOperatorToSolution(op: "*")
                        })
                        OperatorButton(op: "/", action: {
                            numbersViewModel.addOperatorToSolution(op: "/")
                        })
                    }
                    .padding()

                    Button(action: {
                        numbersViewModel.showFinalSolution()
                        if numbersViewModel.finalSolution == numbersViewModel.targetNumber {
                            gameViewModel.score += 10
                        } else if let _ = numbersViewModel.finalSolution {
                            gameViewModel.score += 5
                        }
                    }) {
                        Text("Comprobar solución")
                            .frame(width: 200, height: 50)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    Button(action: numbersViewModel.resetNumbersRound) {
                        Text("Reiniciar")
                            .frame(width: 200, height: 50)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()

                    Button(action: {
                        gameViewModel.resetGame()
                    }) {
                        HStack {
                            Image(systemName: "arrowshape.turn.up.backward.fill")
                                .font(.title)
                            Text("Main Menu")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                        .padding()
                        .background(Color.yellow)
                        .foregroundColor(.white)
                        .cornerRadius(40)
                        .shadow(radius: 10)
                    }
                    .padding(.bottom, 20)
                }
            }
        }
        .onAppear {
            gameViewModel.startTimer()
        }
        .onDisappear {
            gameViewModel.stopTimer()
        }
    }
}

struct NumberSlotView: View {
    var number: Int
    var isUsed: Bool
    var color: Color = .gray

    var body: some View {
        Text("\(number)")
            .frame(width: 50, height: 50)
            .background(isUsed ? Color.red : color)
            .foregroundColor(isUsed ? Color.white : Color.black)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}

struct TargetNumberSlotView: View {
    var number: Int

    var body: some View {
        Text("\(number)")
            .frame(width: 50, height: 50)
            .background(Color.yellow)
            .foregroundColor(Color.black)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.black, lineWidth: 2)
            )
    }
}

struct OperatorButton: View {
    var op: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(op)
                .frame(width: 50, height: 50)
                .background(Color.gray)
                .foregroundColor(.white)
                .cornerRadius(25)
                .overlay(
                    Circle()
                        .stroke(Color.pink, lineWidth: 2)
                )
        }
    }
}

struct NumbersGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGameView(numbersViewModel: NumbersViewModel(game: GameModel()), gameViewModel: GameViewModel(game: GameModel()))
    }
}
