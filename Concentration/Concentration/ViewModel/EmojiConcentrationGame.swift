//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

class EmojiConcentrationGame: ObservableObject {
    @Published private var game = createGame()
    
    static var emojis = ["🥨", "🥑", "🥭", "🌶", "🍏"]
    
    static func createGame() -> ConcentrationGame<String> {                         ConcentrationGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) {
            index in
            emojis[index]
        }
    }
    
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    // MARK: - Intents
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        game.choose(card)
    }
    
}
