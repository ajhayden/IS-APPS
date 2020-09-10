//
//  EmojiConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

struct EmojiConcentrationGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    
    var fontForGameSize: Font {
        emojiGame.cards.count < 10 ? .largeTitle : .body
    }
    
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card, emojiFont: fontForGameSize).onTapGesture {
                    emojiGame.choose(card)
                }
            }
        }
        .padding()
        .foregroundColor(.blue)
    }
}

struct EmojiConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame())
    }
}
