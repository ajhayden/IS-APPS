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
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Pie(startAngle: Angle.degrees(130-90), endAngle: Angle.degrees(360-90))
                        .opacity(0.4)
                        .padding()
                    Text(card.content)
                        .font(systemFont(for: geometry.size))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(Animation.linear(duration: 1)
                                    .repeatForever(autoreverses: false))
                }
                .cardify(isFaceUp: card.isFaceUp)
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * fontScaleFactor)
    }
    
    // MARK: - Drawing constants
    
    private let cardAspectRatio: CGFloat = 2/3
    private let fontScaleFactor: CGFloat = 0.70
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: ConcentrationGame<String>.Card(isFaceUp: true, content: "🥝", id: 1))
            .padding(50)
    }
}
