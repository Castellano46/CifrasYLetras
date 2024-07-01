//
//  HowToPlayView.swift
//  CifrasYLetras
//
//  Created by Pedro on 30/6/24.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        VStack {
            Text("Cómo Jugar")
                .font(.largeTitle)
                .padding()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Juego de Letras")
                        .font(.title)
                        .padding(.top)
                    
                    Text("En el Juego de Letras, debes formar la palabra más larga posible usando las letras seleccionadas. Selecciona vocales y consonantes para completar las 10 letras. El temporizador comenzará una vez que se hayan seleccionado todas las letras.")
                    
                    Text("Juego de Cifras")
                        .font(.title)
                        .padding(.top)
                    
                    Text("En el Juego de Cifras, debes llegar al número objetivo utilizando los números seleccionados y las operaciones matemáticas. Selecciona números para completar los 6 números. El temporizador comenzará una vez que se hayan seleccionado todos los números.")
                    
                    Text("Temporizador")
                        .font(.title)
                        .padding(.top)
                    
                    Text("El temporizador se inicia automáticamente una vez que todas las letras o números hayan sido seleccionados. Puedes pausar y reanudar el temporizador según sea necesario.")
                }
                .padding()
            }
        }
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
