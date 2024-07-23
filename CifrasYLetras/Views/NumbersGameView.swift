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
                    if gameViewModel.timerValue > 0 {
                        Text("Tiempo: \(gameViewModel.timerValue)")
                            .font(.title)
                            .padding()
                    }

                    HStack {
                        Button(action: numbersViewModel.selectNumber) {
                            RealisticButton(color: .blue, iconName: "123.rectangle.fill")
                        }
                        .padding()
                        .disabled(numbersViewModel.selectedNumbers.count == 6)
                        
                        Button(action: numbersViewModel.undoLastOperation) {
                            RealisticButton(color: .red, iconName: "arrow.uturn.backward.circle.fill")
                        }
                        .padding()
                    }

                    HStack {
                        ForEach(0..<4) { index in
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
                    .padding(.vertical, 2)

                    HStack {
                        ForEach(4..<6) { index in
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
                        OperatorButton(op: "+", action: {
                            numbersViewModel.addOperatorToSolution(op: "+")
                        })
                        OperatorButton(op: "-", action: {
                            numbersViewModel.addOperatorToSolution(op: "-")
                        })
                        OperatorButton(op: "x", action: {
                            numbersViewModel.addOperatorToSolution(op: "*")
                        })
                        OperatorButton(op: "/", action: {
                            numbersViewModel.addOperatorToSolution(op: "/")
                        })
                    }
                    .padding()
                    .bold()

                    HStack {
                        ForEach(0..<5) { index in
                            NumberSlotView(number: numbersViewModel.intermediateResults.count > index ? numbersViewModel.intermediateResults[index] : 0, isUsed: numbersViewModel.usedNumbers.contains(numbersViewModel.intermediateResults.count > index ? numbersViewModel.intermediateResults[index] : 0), color: .blue)
                                .frame(width: 50, height: 50)
                                .padding(.horizontal, 5)
                                .onTapGesture {
                                    if numbersViewModel.intermediateResults.count > index {
                                        numbersViewModel.selectNumberForOperation(number: numbersViewModel.intermediateResults[index])
                                    }
                                }
                        }
                    }
                    .padding()

                    ZStack {
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.beige)
                            .frame(height: 50)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.black, lineWidth: 2)
                            )

                        Text("Solución Final: \(numbersViewModel.finalSolution ?? 0)")
                            .font(.title)
                            .foregroundColor(numbersViewModel.finalSolution == numbersViewModel.targetNumber ? .green : .red)
                            .padding()
                    }
                    .padding()
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
            .background(isUsed ? Color.red.opacity(0.8) : color)
            .foregroundColor(isUsed ? Color.white : Color.black)
            .bold()
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

extension Color {
    static let beige = Color(red: 245 / 255, green: 245 / 255, blue: 220 / 255)
}

struct NumbersGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGameView(numbersViewModel: NumbersViewModel(game: GameModel()), gameViewModel: GameViewModel(game: GameModel()))
    }
}
