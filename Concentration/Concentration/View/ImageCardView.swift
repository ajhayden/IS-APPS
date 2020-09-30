//
//  ImageCardView.swift
//  Concentration
//
//  Created by Student on 9/28/20.
//

import SwiftUI

struct ImageCardView: View {
    var card: ConcentrationGame<Image>.Card
    
    @State private var animatedBonusRemaining = 0.0
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: angle(for: 0), endAngle: angle(for: -animatedBonusRemaining), clockwise: true)
                                .onAppear() {
                                    startBonusTimeAnimation()
                                }
                        } else {
                            Pie(startAngle: Angle.degrees(0-90), endAngle: angle(for: -card.bonusRemaining), clockwise: true)
                        }
                    }
                    .opacity(0.4)
                    .padding()
                    .transition(.identity)
                    
                    Text(card.content)
                        .font(systemFont(for: geometry.size))
                        .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1)
                                    .repeatForever(autoreverses: false) : .default)
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
    }
    
    private func angle(for degrees: Double) -> Angle {
        Angle.degrees(degrees * 360 - 90)
    }
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    private func systemFont(for size: CGSize) -> Font {
        return Font.system(size: min(size.width, size.height) * fontScaleFactor)
    }
    
    // MARK: - Drawing constants
    
    private let cardAspectRatio: CGFloat = 9/10
    private let fontScaleFactor: CGFloat = 0.70
}

struct ImageCardView_Previews: PreviewProvider {
    static var previews: some View {
        ImageCardView(card: ConcentrationGame<Image>.Card(isFaceUp: true, content: Image("rome_italy_europe"), id: 1))
            .padding(50)
    }
}
