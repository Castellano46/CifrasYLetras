//
//  SplashView.swift
//  CifrasYLetras
//
//  Created by Pedro on 25/6/24.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Image("fondo")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .overlay(
                    VStack {
                        Spacer()
                        ProgressView(NSLocalizedString("Cifras y Letras", comment: ""))
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .foregroundColor(Color(UIColor(red: 100/255.0, green: 15/255.0, blue: 48/255.0, alpha: 1.0)))
                            .font(.system(size: 20, weight: .bold))
                            .scaleEffect(2.0)
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

