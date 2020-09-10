//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import Foundation

struct ConcentrationGame<CardContent> {
    var cards: Array<Card>
    
    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)
            
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
        
    }
    
    func choose(card: Card) {
        print("You chose \(card)")
    }
    
    struct Card {
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
    }
}


