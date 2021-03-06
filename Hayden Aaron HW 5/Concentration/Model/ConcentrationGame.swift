//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Steve Liddle on 9/4/20.
//

import Foundation

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    var cards: Array<Card>
    var result = 0
    
    var indexOfTheOneAndOnlyOneFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }

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
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    result = result + 2
                    // Make the cards the vanish and nothing happens
                } else {
                    if(cards[chosenIndex].isChecked == true || cards[potentialMatchIndex].isChecked == true) {
                        result = result - 1
                    }
                    cards[chosenIndex].isChecked = true
                    cards[potentialMatchIndex].isChecked = true
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyOneFaceUpCard = chosenIndex
            }
        }
    }

    struct Card: Identifiable {
        var isFaceUp = false
        var isMatched = false
        var isChecked = false
        var content: CardContent
        var id: Int
    }
}
