//
//  ContentView.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

struct ContentView: View {
    var viewModel: EmojiConcentrationGame
    
    var body: some View {
        HStack {
            ForEach(0..<4, content: { index in
                CardView(card: viewModel.cards[index])
            })
        }
        .padding()
        .foregroundColor(.blue)
    }
}

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                Text(card.content)
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: EmojiConcentrationGame())
    }
}
