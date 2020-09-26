//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

class EmojiTheme: Identifiable {
    var name: String
    var emojis: [String]
    var color: Color
    var numberOfPairsOfCards: Int
    
    init(name: String, emojis: [String], color: Color, numberOfPairsOfCards: Int) {
        self.name = name
        self.emojis = emojis
        self.color = color
        self.numberOfPairsOfCards = numberOfPairsOfCards
    }
}

class EmojiConcentrationGame: ObservableObject {
    @Published private var game = createGame()
    
    static var indexOfTheme: Int = 0
    
    init(indexOfTheme: Int) {
        EmojiConcentrationGame.indexOfTheme = indexOfTheme
    }

    static var emojis = [
        EmojiTheme(name: "Animals", emojis: ["🦉", "🦆", "🦘", "🐿", "🦔"], color: Color.purple, numberOfPairsOfCards: 3),
        EmojiTheme(name: "Breads", emojis: ["🥐", "🍞", "🥖", "🧇", "🥯"], color: Color.green, numberOfPairsOfCards: 3),
        EmojiTheme(name: "Faces", emojis: ["😀", "😉", "😇", "😡", "😜"], color: Color.yellow, numberOfPairsOfCards: 3),
        EmojiTheme(name: "Fruits", emojis: ["🍓", "🍐", "🍊", "🍑", "🥝"], color: Color.orange, numberOfPairsOfCards: 3),
        EmojiTheme(name: "Sports", emojis: ["🏀", "⚽️", "🏈", "⚾️", "🎾"], color: Color.red, numberOfPairsOfCards: 3),
        EmojiTheme(name: "Random", emojis: [randomEmoji(), randomEmoji(), randomEmoji(), randomEmoji(), randomEmoji()], color: Color.blue, numberOfPairsOfCards: 3)
    ]
    
    private static func randomEmoji()->String{
            let emojiStart = 0x1F601
            let ascii = emojiStart + Int(arc4random_uniform(UInt32(500)))
            let emoji = UnicodeScalar(ascii)?.description
            return emoji ?? "x"
    }
    
    private static func createGame() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: emojis[EmojiConcentrationGame.indexOfTheme].numberOfPairsOfCards) {
            index in
            emojis[EmojiConcentrationGame.indexOfTheme].emojis[index]
        }
    }
    
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        game.cards
    }
    
    var score: Int {
        var totalScore = 0
        
        for card in cards {
            if card.isMatched {
                totalScore += 1
            }
            
            totalScore -= card.mismatchedCount
        }
        
        return totalScore
    }
    
    // MARK: - Intents
    
    func choose(_ card: ConcentrationGame<String>.Card) {
        game.choose(card)
    }
    
    func resetCards() {
        game = EmojiConcentrationGame.createGame()
    }
    
}
