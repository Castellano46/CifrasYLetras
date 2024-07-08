//
//  ContentView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var gameViewModel = GameViewModel(game: GameModel())
    @StateObject private var lettersViewModel = LettersViewModel(game: GameModel())
    @StateObject private var numbersViewModel = NumbersViewModel(game: GameModel())
    @State private var showHome = false
    
    var body: some View {
        Group {
            if showHome {
                HomeView(viewModel: gameViewModel, lettersViewModel: lettersViewModel, numbersViewModel: numbersViewModel)
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation {
                                showHome = true
                            }
                        }
                    }
            }
        }
    }
}

#Preview{
    ContentView()
}

//struct ContentView_Previews: PreviewProvider {
  //  static var previews: some View {
    //    ContentView()
    //}
//}

