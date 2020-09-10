//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

class EmojiConcentrationGame {
    private var game = createGame()
    static var emojis = ["🥨", "🥑", "🥭", "🌶", "🍏"]
    static var randomNum = Int.random(in: 2...5)
    
    static func createGame() -> ConcentrationGame<String> {                         ConcentrationGame<String>(numberOfPairsOfCards: randomNum) { index in
            emojis[index]
        }
    }
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    // MARK: - Intents
    
    func choose(card: ConcentrationGame<String>.Card) {
        game.choose(card: card)
    }
    
}
