//
//  ContentView.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = GameViewModel(game: GameModel())
    @State private var showHome = false
    
    var body: some View {
        Group {
            if showHome {
                HomeView(viewModel: viewModel)
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
