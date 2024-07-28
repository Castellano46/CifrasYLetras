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
            
            VStack {
                HStack {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(systemName: "clock")
                                .font(.title)
                                .bold()
                                .foregroundColor(.blue)
                                .background(Circle().fill(Color.yellow).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2).frame(width: 50, height: 50))
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
                                .background(Circle().fill(Color.green).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2).frame(width: 50, height: 50))
                            Text("\(gameViewModel.score)")
                                .font(.title)
                                .bold()
                                .foregroundColor(.yellow)
                                .padding(.leading, 10)
                        }
                        .padding(.bottom, 10)
                        .padding(.leading, 20)
                    }
                    .padding(.top, 30)
                    
                    Spacer()
                    
                    VStack {
                        if gameViewModel.isTimerActive {
                            Button(action: gameViewModel.pauseTimer) {
                                Image(systemName: "pause.fill")
                                    .font(.title)
                                    .foregroundColor(.orange)
                                    .background(Circle().fill(Color.white).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2).frame(width: 50, height: 50))
                                    .padding()
                            }
                        } else if gameViewModel.isPaused {
                            Button(action: gameViewModel.resumeTimer) {
                                Image(systemName: "play.fill")
                                    .font(.title)
                                    .foregroundColor(.green)
                                    .background(Circle().fill(Color.white).shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 2).frame(width: 50, height: 50))
                                    .padding()
                            }
                        }
                    }
                    .padding(.top, 30)
                    .padding(.trailing, 10)
                }
                .padding(.horizontal)
                
                Spacer()
                
                ScrollView {
                    VStack(spacing: 1) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .fill(Color.beige)
                                .frame(width: 300)
                                .frame(height: 35)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color.black, lineWidth: 2)
                                )
                            
                            Text("Solución: \(numbersViewModel.finalSolution ?? 0)")
                                .font(.title)
                                .foregroundColor(numbersViewModel.finalSolution == numbersViewModel.targetNumber ? .green : .red)
                                .padding()
                        }
                        .padding()
                        
                        HStack(spacing: 15) {
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
                                .frame(width: 60, height: 60)
                                .padding(.horizontal, 5)
                            }
                        }
                        .padding(.vertical, 2)
                        
                        HStack(spacing: 15) {
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
                                .frame(width: 60, height: 60)
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
                        
                        HStack(spacing: 8) {
                            ForEach(0..<5) { index in
                                NumberSlotView(number: numbersViewModel.intermediateResults.count > index ? numbersViewModel.intermediateResults[index] : 0, isUsed: numbersViewModel.usedNumbers.contains(numbersViewModel.intermediateResults.count > index ? numbersViewModel.intermediateResults[index] : 0), color: .blue)
                                    .frame(width: 60, height: 60)
                                    .padding(.horizontal, 5)
                                    .onTapGesture {
                                        if numbersViewModel.intermediateResults.count > index {
                                            numbersViewModel.selectNumberForOperation(number: numbersViewModel.intermediateResults[index])
                                        }
                                    }
                            }
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
                    }
                }
                
                Spacer()
                
                HStack {
                    Button(action: {
                        numbersViewModel.selectNumber()
                        if numbersViewModel.selectedNumbers.count == 6 {
                            gameViewModel.allNumbersSelected()
                        }
                    }) {
                        RealisticButton(color: .blue, iconName: "123.rectangle.fill")
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 40)
                    .disabled(numbersViewModel.selectedNumbers.count == 6)
                    
                    Button(action: numbersViewModel.undoLastOperation) {
                        RealisticButton(color: .red, iconName: "arrow.uturn.backward.circle.fill")
                            .frame(width: 100, height: 100)
                    }
                    .padding(.horizontal, 40)
                }
                .padding()
                
                Spacer(minLength: 70)
            }
        }
        .onAppear {
            gameViewModel.timerValue = 40
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
            .frame(width: 60, height: 60)
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
        let gameModel = GameModel()
        let numbersViewModel = NumbersViewModel(game: gameModel)
        let gameViewModel = GameViewModel(game: gameModel)
        numbersViewModel.delegate = gameViewModel 
        return NumbersGameView(numbersViewModel: numbersViewModel, gameViewModel: gameViewModel)
    }
}
