//
//  EmojiConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

struct EmojiConcentrationGameView: View {
    @ObservedObject var emojiGame: EmojiConcentrationGame
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
    
    var body: some View {
        GeometryReader { geometry in
            LazyVGrid(columns: columns(for: geometry.size) ) {
                ForEach(emojiGame.cards) { card in
                    CardView(card: card)
                        .onTapGesture {
                        emojiGame.choose(card)
                    }
                }
            }
            .padding()
            .foregroundColor(.purple)
            
            HStack {
                VStack {
                    Text("Score: \(emojiGame.result)")
                        .bold()
                        .foregroundColor(Color.purple)
                        .font(.system(size: 20))
                }
                .padding(.leading, 130)
                Spacer()
                VStack {
                    Button(action: {
                        emojiGame.resetCards()
                    }) {
                        Text("New Game")
                            .foregroundColor(Color.white)
                            .frame(width: 110, height: 80)
                            .background(Color.black)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.system(size: 19))                    }
                }
            }
            .padding(.top, 600)
            .padding()
        }
    }
    
    //MARK: - Drawing constants
    
    private let desiredCardWidth: CGFloat = 100
}

struct EmojiConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame())
    }
}
