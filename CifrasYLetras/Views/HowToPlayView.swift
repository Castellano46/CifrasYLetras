//
//  HowToPlayView.swift
//  CifrasYLetras
//
//  Created by Pedro on 30/6/24.
//

import SwiftUI

struct HowToPlayView: View {
    var body: some View {
        ZStack {
            Color(red: 1.0, green: 0.94, blue: 0.84)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Cómo Jugar")
                    .font(.custom("Marker Felt", size: 60))
                    .padding()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        SectionHeaderView(title: "Juego de Letras")
                        
                        Text("En el Juego de Letras, debes formar la palabra más larga posible usando las letras seleccionadas. Selecciona vocales y consonantes para completar las 10 letras. Por cada letra utilizada en tu palabra obtendrás un punto. El temporizador comenzará una vez que se hayan seleccionado todas las letras.")
                            .font(.custom("Marker Felt", size: 28))
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 20)
                        
                        SectionHeaderView(title: "Juego de Cifras")
                        
                        Text("En el Juego de Cifras, debes llegar al número objetivo utilizando los números seleccionados y las operaciones matemáticas elementales. Pulsa sobre el botón ***Número*** para completar los 6 números con los que jugarás. Cuando todos tus números estén en su casilla correspondiente aparecerá el número objetivo. Si al utilizar las operaciones llegas a una cifra aproximada obtendrás 5 puntos y si llegas a la exacta obtendrás 10 puntos. El temporizador comenzará una vez que se hayan seleccionado todos los números.")
                            .font(.custom("Marker Felt", size: 28))
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 20)
                        
                        SectionHeaderView(title: "Temporizador")
                        
                        Text("El temporizador se inicia automáticamente una vez que todas las letras o números hayan sido seleccionados. Puedes pausar y reanudar el temporizador según sea necesario. Si el temporizador se encuentra en ***Pausa*** no podrás realizar ninguna acción en el juego.")
                            .font(.custom("Marker Felt", size: 28))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding(.horizontal, 10)
                    .foregroundColor(.black)
                }
                .padding()
            }
            .font(.custom("Marker Felt", size: 28))
            .foregroundColor(.black)
        }
    }
}

struct SectionHeaderView: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.custom("Marker Felt", size: 40))
            .padding(.top)
    }
}

struct HowToPlayView_Previews: PreviewProvider {
    static var previews: some View {
        HowToPlayView()
    }
}
