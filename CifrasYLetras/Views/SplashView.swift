//
//  SplashView.swift
//  CifrasYLetras
//
//  Created by Pedro on 25/6/24.
//

import SwiftUI
import Lottie

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("fondo")
                .resizable()
                .scaledToFill()
                .opacity(0.5)
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Spacer()
                        LottieView(animationName: "load",
                                   loopMode: .loop,
                                   contentMode: .scaleAspectFit)
                        .frame(width: 450, height: 450)
                        Spacer()
                    }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                )
        }
    }
}

#Preview {
    SplashView()
}
