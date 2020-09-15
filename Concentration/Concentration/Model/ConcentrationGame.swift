//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Steve Liddle on 9/4/20.
//

import Foundation

struct ConcentrationGame<CardContent> {
    var cards: Array<Card>

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()

        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)

            cards.append(Card(content: content, id: pairIndex * 2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }

        cards.shuffle()
    }

    mutating func choose(_ card: Card) {
        print("You chose \(card)")

        if let cardIndex = cards.index(of: card) {
            cards[cardIndex].isFaceUp.toggle()
        }
    }

    struct Card: Identifiable {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
        var id: Int
    }
}
