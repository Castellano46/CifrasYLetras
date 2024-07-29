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
                        
                        Text("En el Juego de Letras, debes formar la palabra más larga posible usando las letras seleccionadas. Pulsa sobre el botón ***V*** si quieres que el siguiente cuadrado se rellene con una vocal o el botón ***C*** si por el contrario prefieres una consonante hasta completar las 10 letras. Por cada letra utilizada en tu palabra obtendrás un punto que se sumará a tu contador final ⭐️. El temporizador comenzará una vez que se hayan seleccionado todas las letras.")
                            .font(.custom("Marker Felt", size: 28))
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 20)
                        
                        SectionHeaderView(title: "Juego de Cifras")
                        
                        Text("En el Juego de Cifras, debes llegar al número objetivo utilizando los números seleccionados y las operaciones matemáticas elementales. Pulsa sobre el botón 🔢 para completar los 6 números con los que jugarás. Cuando todos tus números estén en su casilla correspondiente aparecerá el número objetivo, al cual deberás llegar o aproximarte utilizando las operaciones básicas. Si al utilizar las operaciones llegas a una cifra aproximada obtendrás 5 puntos y si llegas a la exacta obtendrás 10 puntos. Podrás borrar las operaciones que has utilizado pulsando sobre el boton ↩️. El temporizador comenzará una vez que se hayan seleccionado todos los números.")
                            .font(.custom("Marker Felt", size: 28))
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.bottom, 20)
                        
                        SectionHeaderView(title: "Temporizador")
                        
                        Text("El temporizador se inicia automáticamente una vez que todas las letras o números hayan sido seleccionados. Cuando el juego comienze contarás con 40 segundos para encontrar la palabra más larga, en el juego de ***'Letras'*** o el número objetivo en el juego de ***'Cifras'***. Puedes pausar y reanudar el temporizador según sea necesario. Si el temporizador se encuentra en ***Pausa*** no podrás realizar ninguna acción en el juego.")
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
