//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Steve Liddle on 9/4/20.
//

import Foundation

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    var result = 0
    
    private var indexOfTheOneAndOnlyOneFaceUpCard: Int? {
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
            
            cards[chosenIndex].viewedCount += 1
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                } else {
                    cards[chosenIndex].markMismatched()
                    cards[potentialMatchIndex].markMismatched()
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyOneFaceUpCard = chosenIndex
            }
        }
    }

    struct Card: Identifiable {
        fileprivate(set) var isFaceUp = false
        fileprivate(set) var isMatched = false
        fileprivate(set) var mismatchedCount = 0
        fileprivate(set) var viewedCount = 0
        fileprivate(set) var content: CardContent
        fileprivate(set) var id: Int
        
        fileprivate mutating func markMismatched() {
            if viewedCount > 1 {
                mismatchedCount += 1
            }
        }
    }
}
