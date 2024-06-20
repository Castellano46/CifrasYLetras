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
            
            Text("Número objetivo: \(viewModel.targetNumber)")
                .font(.title)
                .padding()
            
            HStack {
                ForEach(viewModel.availableNumbers, id: \.self) { number in
                    Text("\(number)")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding()
            
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
            
            Button(action: viewModel.advanceToNextPhase) {
                Text("Siguiente")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

struct NumbersGameView_Previews: PreviewProvider {
    static var previews: some View {
        NumbersGameView(viewModel: GameViewModel(game: GameModel()))
    }
}
