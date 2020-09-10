//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

class EmojiConcentrationGame {
    private var game = createGame()
    
    static func createGame() -> ConcentrationGame<String> {                         ConcentrationGame<String>(numberOfPairsOfCards: 2) { index in
            index > 0 ? "🥨" : "🥑"
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
