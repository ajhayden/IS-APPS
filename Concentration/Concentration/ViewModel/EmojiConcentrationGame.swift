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
    @Published private var game: ConcentrationGame<String>
    @Published private var isVisable = false
    
    var indexOfTheme: Int
    
    init(indexOfTheme: Int = 0) {
        self.indexOfTheme = indexOfTheme
        EmojiConcentrationGame.emojiThemes[EmojiConcentrationGame.emojiThemes.count - 1] = EmojiConcentrationGame.randomEmojiTheme()
        game = EmojiConcentrationGame.createGame(indexOfTheme)
    }
    
    static var emojiThemes = [
        EmojiTheme(name: "Animals", emojis: ["🦉", "🦆", "🦘", "🐿", "🦔", "🐇"], color: Color.purple, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Breads", emojis: ["🥐", "🍞", "🥖", "🧇", "🥯", "🥞"], color: Color.green, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Faces", emojis: ["😀", "😉", "😇", "😡", "😜", "🥶"], color: Color.yellow, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Fruits", emojis: ["🍓", "🍐", "🍊", "🍑", "🥝", "🍍"], color: Color.orange, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Sports", emojis: ["🏀", "⚽️", "🏈", "⚾️", "🎾", "🏐"], color: Color.red, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Random", emojis: [], color: Color.blue, numberOfPairsOfCards: 6)
    ]
    
    static var additonalColors = [
        Color.pink,
        Color.blue,
        Color.black,
        Color.gray,
        Color.green,
        Color.yellow,
        Color.orange,
        Color.red,
        Color.purple
    ]
    
    private static func randomEmojiTheme() -> EmojiTheme {
        let randomIndexEmojis = Int.random(in:0...EmojiConcentrationGame.emojiThemes.count - 2)
        let randomIndexNumberOfPairs = Int.random(in:2...6)
        return EmojiTheme(name: "Random", emojis: EmojiConcentrationGame.emojiThemes[randomIndexEmojis].emojis, color: EmojiConcentrationGame.additonalColors.randomElement() ?? .red, numberOfPairsOfCards: randomIndexNumberOfPairs)
    }
    
    private static func createGame(_ indexOfTheme: Int, overrideNumber: Int? = nil) -> ConcentrationGame<String> {
        if overrideNumber == nil {
            return ConcentrationGame<String>(numberOfPairsOfCards: emojiThemes[indexOfTheme].numberOfPairsOfCards) {
                index in
                emojiThemes[indexOfTheme].emojis[index]
            }
        } else {
            return ConcentrationGame<String>(numberOfPairsOfCards: overrideNumber!) {
                index in
                emojiThemes[indexOfTheme].emojis[index]
            }
        }
    }
    
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<String>.Card> {
        if isVisable {
            return game.cards
        } else {
            return []
        }
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
    
    var cardColor: Color {
        EmojiConcentrationGame.emojiThemes[indexOfTheme].color
    }
    
    var userDefault: UserDefaults {
        game.defaults
    }
    
    // MARK: - Intents
    
    func choose(_ card: ConcentrationGame<String>.Card, gameType: String = "emoji", gameTheme: String, score: String) {
        game.choose(card, gameType, gameTheme, score)
    }
    
    func dealCards() {
        isVisable = true
    }
    
    func resetCards() {
        EmojiConcentrationGame.emojiThemes[EmojiConcentrationGame.emojiThemes.count - 1] = EmojiConcentrationGame.randomEmojiTheme()
        game = EmojiConcentrationGame.createGame(indexOfTheme)
    }
    
    func resetCardsBySettings(newNumberOfPairsOfCards: Int = 2) {
        EmojiConcentrationGame.emojiThemes[EmojiConcentrationGame.emojiThemes.count - 1] = EmojiConcentrationGame.randomEmojiTheme()
        game = EmojiConcentrationGame.createGame(indexOfTheme, overrideNumber: newNumberOfPairsOfCards)
    }
    
}
