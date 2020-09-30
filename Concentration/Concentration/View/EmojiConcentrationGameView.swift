//
//  EmojiConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

struct EmojiConcentrationGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame

    var cardColor: Color = Color.black
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    Text("Score: \(emojiGame.score)")
                        .bold()
                        .foregroundColor(cardColor)
                        .font(.system(size: 20))
                    Spacer()
                    Button("New Game") {
                        withAnimation(.easeInOut) {
                            emojiGame.resetCards()
                        }
                    }
                    .foregroundColor(Color.white)
                    .frame(width: 110, height: 60)
                    .background(cardColor)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .font(.system(size: 19))
                }
                .padding(.top, 20)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                GeometryReader { geometry in
                    LazyVGrid(columns: columns(for: geometry.size) ) {
                        ForEach(emojiGame.cards) { card in
                            CardView(card: card)
                                .transition(AnyTransition.offset(
                                    randomLocationOffScreen(for: geometry.size)
                                ))
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        emojiGame.choose(card, gameType: "emoji", gameTheme: "\(EmojiConcentrationGame.emojiThemes[emojiGame.indexOfTheme].name)", score: "\(emojiGame.score)")
                                    }
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .foregroundColor(cardColor)
                }
            }
        }
    }
    

    func randomLocationOffScreen(for size: CGSize) -> CGSize {
        var randomSize = CGSize.zero
        let randomAngle = Double.random(in: 0..<Double.pi * 2)
        let scaleFactor = max(size.width, size.height) * 1.5
        
        randomSize.width = CGFloat(sin(randomAngle)) * scaleFactor
        randomSize.height = CGFloat(cos(randomAngle)) * scaleFactor
        
        return randomSize
    }
    
    //MARK: - Drawing constants
    
    private let desiredCardWidth: CGFloat = 100
}

struct EmojiConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(indexOfTheme: 0))
    }
}
