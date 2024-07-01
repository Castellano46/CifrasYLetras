//
//  NumbersGameView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct NumbersGameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Cifras")
                .font(.largeTitle)
                .padding()
            
            if viewModel.timerValue > 0 {
                Text("Tiempo: \(viewModel.timerValue)")
                    .font(.title)
                    .padding()
            }
            
            Button(action: viewModel.selectNumber) {
                Text("Número")
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
            .disabled(viewModel.selectedNumbers.count == 6)
            
            HStack {
                ForEach(0..<6) { index in
                    GeometryReader { geometry in
                        if index < viewModel.selectedNumbers.count {
                            NumberSlotView(number: viewModel.selectedNumbers[index], isUsed: viewModel.usedNumbers.contains(viewModel.selectedNumbers[index]))
                                .onTapGesture {
                                    viewModel.addNumberToSolution(number: viewModel.selectedNumbers[index])
                                }
                        } else {
                            Rectangle()
                                .frame(width: geometry.size.width, height: geometry.size.height)
                                .foregroundColor(Color.gray.opacity(0.1))
                                .cornerRadius(8)
                        }
                    }
                    .frame(width: 50, height: 50)
                    .padding(.horizontal, 5)
                }
            }
            .padding()
            
            HStack {
                NumberSlotView(number: viewModel.targetHundreds, isUsed: false)
                NumberSlotView(number: viewModel.targetTens, isUsed: false)
                NumberSlotView(number: viewModel.targetUnits, isUsed: false)
            }
            .padding()
            
            if viewModel.isTimerActive {
                Button(action: viewModel.pauseTimer) {
                    Image(systemName: "pause.fill")
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            } else if viewModel.isPaused {
                Button(action: viewModel.resumeTimer) {
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
                        viewModel.addOperatorToSolution(op: "+")
                    }) {
                        Text("+")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(25)
                    }
                    
                    Button(action: {
                        viewModel.addOperatorToSolution(op: "-")
                    }) {
                        Text("-")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(25)
                    }
                    
                    Button(action: {
                        viewModel.addOperatorToSolution(op: "*")
                    }) {
                        Text("*")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(25)
                    }
                    
                    Button(action: {
                        viewModel.addOperatorToSolution(op: "/")
                    }) {
                        Text("/")
                            .font(.title)
                            .frame(width: 50, height: 50)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(25)
                    }
                }
                .padding()
                
                Text(viewModel.userSolution)
                    .font(.title)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
                HStack {
                    Button(action: viewModel.removeLastEntryFromSolution) {
                        Text("Borrar")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    
                    Button(action: {
                        viewModel.showFinalSolution()
                    }) {
                        Text("Comprobar solución")
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding()
            }
        }
        .padding()
    }
}

struct NumberSlotView: View {
    var number: Int
    var isUsed: Bool
    
    var body: some View {
        Text("\(number)")
            .font(.largeTitle)
            .frame(width: 50, height: 50)
            .background(isUsed ? Color.red.opacity(0.5) : Color.yellow.opacity(0.3))
            .cornerRadius(8)
    }
}

struct NumbersGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGameView(viewModel: GameViewModel(game: GameModel()))
    }
}
