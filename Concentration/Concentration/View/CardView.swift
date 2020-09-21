//
//  CardView.swift
//  Concentration
//
//  Created by Student on 9/10/20.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if card.isFaceUp || !card.isMatched {
                    if card.isFaceUp {
                        RoundedRectangle(cornerRadius: cardCornerRadius).fill(Color.white)
                        RoundedRectangle(cornerRadius: cardCornerRadius).stroke()
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(360-90)).padding()
                        Text(card.content)
                                .font(systemFont(for: geometry.size))
                    } else {
                        RoundedRectangle(cornerRadius: cardCornerRadius).fill()
                    }
                }
            }
        }
        .aspectRatio(2/3, contentMode: .fit)
    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height * fontScaleFactor))
    }
    
    // MARK: - Drawing constants
    
    private let cardCornerRadius: CGFloat = 10.0
    private let fontScaleFactor: CGFloat = 0.70
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: ConcentrationGame<String>.Card(content: "🥝", id: 1))
            .padding(50)
    }
}
