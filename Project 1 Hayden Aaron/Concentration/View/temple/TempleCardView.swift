//
//  ImageCardView.swift
//  Concentration
//
//  Created by Student on 9/28/20.
//



import SwiftUI

struct TempleCardView: View {
    var card: ConcentrationGame<String>.Card
    
    @State private var animatedBonusRemaining = 0.0
    @State private var animatedNumber = 1
    
    var body: some View {
        GeometryReader { geometry in
            if card.isFaceUp || !card.isMatched {
                ZStack {
                    Image(card.content)
                        .resizable()
                        .aspectRatio(1.2, contentMode: .fit)
                        .font(systemFont(for: geometry.size))
                        .hueRotation(Angle.degrees(card.isMatched ? 360 : 0))
                        .animation(card.isMatched ? Animation.linear(duration: 1)
                                    .repeatForever(autoreverses: false) : .default)
                    Group {
                        if card.isConsumingBonusTime {
                            Pie(startAngle: angle(for: 0), endAngle: angle(for: -animatedBonusRemaining), clockwise: false)
                                .onAppear() {
                                    startBonusTimeAnimation()
                                }
                        }
                    }
                    .opacity(0.5)
                    .padding(20)
                    .transition(.identity)
                    
                    
                }
                .cardify(isFaceUp: card.isFaceUp)
                .transition(.scale)
            }
        }
        .aspectRatio(cardAspectRatio, contentMode: .fit)
    }
    
    private func incrementNumber() -> Int {
        return 0
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
    
    private let cardAspectRatio: CGFloat = 1.5
    private let fontScaleFactor: CGFloat = 0.70
}

struct TempleCardView_Previews: PreviewProvider {
    static var previews: some View {
        TempleCardView(card: ConcentrationGame<String>.Card(isFaceUp: true, content: "rome_italy_europe"))
            .padding(70)
    }
}
