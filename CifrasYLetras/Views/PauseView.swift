//
//  PauseView.swift
//  CifrasYLetras
//
//  Created by Pedro on 9/7/24.
//

import SwiftUI

struct PauseView: View {
    @ObservedObject var gameViewModel: GameViewModel
    
    var body: some View {
        ZStack {
            Image("fondo")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .opacity(0.6)
            
            VStack {
                Spacer()
                
                LottieView(animationName: "pause",
                           loopMode: .loop,
                           contentMode: .scaleAspectFit)
                .frame(width: 250, height: 170)
                .padding(0)
                
                VStack(spacing: 30) {
                    Button(action: {
                        gameViewModel.resumeTimer()
                    }) {
                        HStack {
                            Image(systemName: "play.fill")
                                .font(.title)
                            Text("Resume")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                    }
                    .buttonStyle(StandardButtonStyle(firstColor: Color.yellow, secondColor: Color.blue))
                    .padding(.horizontal, 40)
                    
                    Button(action: {
                        gameViewModel.resetGame()
                    }) {
                        HStack {
                            Image(systemName: "arrow.counterclockwise.circle.fill")
                                .font(.title)
                            Text("Replay")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                    }
                    .buttonStyle(StandardButtonStyle(firstColor: Color.red, secondColor: Color.yellow))
                    .padding(.horizontal, 40)
                    
                    Button(action: {
                        gameViewModel.showMainMenu = true
                    }) {
                        HStack {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                            Text("Exit")
                                .fontWeight(.semibold)
                                .font(.title)
                        }
                    }
                    .buttonStyle(StandardButtonStyle(firstColor: Color.green, secondColor: Color.red))
                    .padding(.horizontal, 40)
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
}

struct StandardButtonStyle: ButtonStyle {
    let firstColor: Color
    let secondColor: Color
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 0, maxWidth: .infinity)
            .padding()
            .foregroundColor(.white)
            .background(LinearGradient(gradient: Gradient(colors: [firstColor, secondColor]), startPoint: .leading, endPoint: .trailing))
            .cornerRadius(40)
            .padding(.horizontal, 20)
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
    }
}

struct PauseView_Previews: PreviewProvider {
    static var previews: some View {
        PauseView(gameViewModel: GameViewModel(game: GameModel()))
    }
}
