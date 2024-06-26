//
//  CifrasYLetrasApp.swift
//  CifrasYLetras
//
//  Created by Pedro on 17/6/24.
//

import SwiftUI

@main
struct CifrasYLetrasApp: App {
    @State private var showContentView = false
    
    var body: some Scene {
        WindowGroup {
            if showContentView {
                ContentView()
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            // Después de 3 segundos, establece showContentView en true
                            showContentView = true
                        }
                    }
            }
        }
    }
}
