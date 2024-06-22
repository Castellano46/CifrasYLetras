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
                            Text("\(viewModel.selectedNumbers[index])")
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
            .frame(height: 100)
            .padding()
            
            if viewModel.selectedNumbers.count == 6 {
                HStack {
                    NumberSlotView(number: viewModel.targetHundreds)
                    NumberSlotView(number: viewModel.targetTens)
                    NumberSlotView(number: viewModel.targetUnits)
                }
                .padding()
                
                Text("Tiempo restante: \(viewModel.timerValue) segundos")
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
                
                Button(action: {
                    let isValid = viewModel.checkSolution()
                }) {
                    Text("Comprobar solución")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

struct NumberSlotView: View {
    var number: Int
    
    var body: some View {
        Text("\(number)")
            .font(.largeTitle)
            .frame(width: 80, height: 80)
            .background(Color.gray.opacity(0.3))
            .cornerRadius(8)
    }
}

struct NumbersGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGameView(viewModel: GameViewModel(game: GameModel()))
    }
}
