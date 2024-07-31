//
//  ColorPreview.swift
//  CifrasYLetras
//
//  Created by Pedro on 31/7/24.
//

import SwiftUI

struct ColorPreview: View {
    let color: Color
    let colorName: String
    
    var body: some View {
        HStack {
            color
                .frame(width: 80, height: 80)
                .cornerRadius(8)
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.black, lineWidth: 1))
            Text(colorName)
                .padding(.leading, 10)
        }
        .padding()
    }
}

struct ColorPreviewList: View {
    let colors: [(Color, String)] = [
        (.beige, "Beige"),
        (.softRed, "Soft Red"),
        (.softGreen, "Soft Green"),
        (.softBlue, "Soft Blue"),
        (.sunnyYellow, "Sunny Yellow"),
        (.brightOrange, "Bright Orange"),
        (.royalPurple, "Royal Purple"),
        (.pastelPink, "Pastel Pink"),
        (.chocolateBrown, "Chocolate Brown"),
        (.midGray, "Mid Gray"),
        (.darkRed, "Dark Red"),
        (.forestGreen, "Forest Green"),
        (.navyBlue, "Navy Blue"),
        (.mustardYellow, "Mustard Yellow"),
        (.burntOrange, "Burnt Orange"),
        (.indigoPurple, "Indigo Purple"),
        (.hotPink, "Hot Pink"),
        (.walnutBrown, "Walnut Brown"),
        (.charcoalGray, "Charcoal Gray"),
        (.lightRed, "Light Red"),
        (.mintGreen, "Mint Green"),
        (.skyBlue, "Sky Blue"),
        (.lemonYellow, "Lemon Yellow"),
        (.peachOrange, "Peach Orange"),
        (.lavenderPurple, "Lavender Purple"),
        (.blushPink, "Blush Pink"),
        (.caramelBrown, "Caramel Brown"),
        (.lightGray, "Light Gray")
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(colors, id: \.1) { color, name in
                    ColorPreview(color: color, colorName: name)
                }
            }
        }
        .padding()
    }
}

struct ColorPreviewList_Previews: PreviewProvider {
    static var previews: some View {
        ColorPreviewList()
    }
}
