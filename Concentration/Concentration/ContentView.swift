//
//  ContentView.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

struct ContentView: View {
    var emojiGame: EmojiConcentrationGame
    
    var body: some View {
        HStack {
            ForEach(emojiGame.cards) { card in
                CardView(card: card, number: EmojiConcentrationGame.randomNum).onTapGesture(perform: {
                    emojiGame.choose(card: card)
                })
            }
        }
        .padding()
        .foregroundColor(.blue)
    }
}

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var number: Int
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                if number >= 5 {
                    Text(card.content)
                        .font(.subheadline)
                } else {
                    Text(card.content)
                        .font(.largeTitle)
                }
                
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }.aspectRatio(2/3, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(emojiGame: EmojiConcentrationGame())
    }
}
