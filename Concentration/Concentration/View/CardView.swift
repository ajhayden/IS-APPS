//
//  CardView.swift
//  Concentration
//
//  Created by Student on 9/10/20.
//

import SwiftUI

struct CardView: View {
    var card: ConcentrationGame<String>.Card
    var emojiFont: Font
    var body: some View {
        ZStack {
            if card.isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                    Text(card.content)
                        .font(emojiFont)
                
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
        }.aspectRatio(2/3, contentMode: .fit)
    }
    
    // MARK: - Drawing constants
    
    private let cardCornerRadius: CGFloat = 10.0
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(card: ConcentrationGame<String>.Card(content: "", id: 1),
                 emojiFont: .largeTitle).padding(50)
    }
}
