//
//  RealisticButton.swift
//  CifrasYLetras
//
//  Created by Pedro on 12/7/24.
//

import SwiftUI

struct RealisticButton: View {
    var color: Color
    var iconName: String
    
    var body: some View {
        ZStack {
            Circle()
                .fill(LinearGradient(
                    gradient: Gradient(colors: [color.opacity(0.6), color.opacity(0.9)]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                ))
                .frame(width: 120, height: 120)
                .shadow(color: color.opacity(0.3), radius: 10, x: 10, y: 10)
                .shadow(color: .white.opacity(0.5), radius: 10, x: -5, y: -5)
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 4)
                )
                .overlay(
                    Circle()
                        .stroke(Color.white.opacity(0.2), lineWidth: 8)
                        .blur(radius: 4)
                        .offset(x: -4, y: -4)
                )
                .overlay(
                    Circle()
                        .stroke(color.opacity(0.7), lineWidth: 8)
                        .blur(radius: 4)
                        .offset(x: 4, y: 4)
                )
                .overlay(
                    Circle()
                        .stroke(LinearGradient(
                            gradient: Gradient(colors: [Color.white.opacity(0.8), Color.clear]),
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ), lineWidth: 8)
                        .blur(radius: 4)
                        .offset(x: -4, y: -4)
                )
            
            Image(systemName: iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.white)
                .shadow(radius: 10)
        }
    }
}

struct RealisticButton_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            RealisticButton(color: .green, iconName: "play.circle.fill")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Green Play Button")
            
            RealisticButton(color: .teal, iconName: "book.circle.fill")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Teal Book Button")
            
            RealisticButton(color: .red, iconName: "trophy.circle.fill")
                .previewLayout(.sizeThatFits)
                .padding()
                .previewDisplayName("Red Trophy Button")
        }
    }
}
