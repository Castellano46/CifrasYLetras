//
//  LettersGameView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct LettersGameView: View {
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        VStack {
            Text("Letras")
                .font(.largeTitle)
                .padding()
            
            HStack {
                ForEach(viewModel.letters, id: \.self) { letter in
                    Text(letter)
                        .font(.largeTitle)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(8)
                }
            }
            .padding()
            
            TextField("Tu palabra", text: $viewModel.userWord)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button(action: {
                let isValid = viewModel.checkWord()
                // Acción según la validación
            }) {
                Text("Comprobar palabra")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            .padding()
        }
    }
}

struct LettersGameView_Previews: PreviewProvider {
    static var previews: some View {
        LettersGameView(viewModel: GameViewModel(game: GameModel(
            letters: ["A", "B", "C", "D", "E", "F", "G"],
            targetNumber: 100,
            availableNumbers: [1, 2, 3, 4, 5, 6]
        )))
    }
}

