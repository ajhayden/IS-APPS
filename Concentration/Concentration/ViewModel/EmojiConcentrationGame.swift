//
//  EmojiConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI



class EmojiConcentrationGame: ObservableObject {
    @Published private var game = createGame()
    
    var emojiType = "animal"
    
    private static var emojis = ["🦉", "🦆", "🦘", "🐿", "🦔"]
    private static var emojis_breads = ["🥐", "🍞", "🥖", "🧇", "🥯"]
    private static var emojis_faces = ["😀", "😉", "😇", "😡", "😜"]
    private static var emojis_fruits = ["🍓", "🍐", "🍊", "🍑", "🥝"]
    private static var emojis_sports = ["🏀", "⚽️", "🏈", "⚾️", "🎾"]
    private static var emojis_random = [randomEmoji(), randomEmoji(), randomEmoji(), randomEmoji(), randomEmoji()]
    
    private static func randomEmoji()->String{
            let emojiStart = 0x1F601
            let ascii = emojiStart + Int(arc4random_uniform(UInt32(500)))
            let emoji = UnicodeScalar(ascii)?.description
            return emoji ?? "x"
    }
    
    private static func createGame() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: Int.random(in: 2...5)) {
            index in
            emojis_random[index]
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
