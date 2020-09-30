//
//  HighScoreViewModel.swift
//  Concentration
//
//  Created by Student on 9/29/20.
//

import SwiftUI

class HighScoreViewModel: ObservableObject {
    @Published private var game: ConcentrationGame<String>
    
    var indexOfTheme: Int
    
    init(indexOfTheme: Int = 0) {
        self.indexOfTheme = indexOfTheme
        HighScoreViewModel.emojiThemes[HighScoreViewModel.emojiThemes.count - 1] = HighScoreViewModel.randomEmojiTheme()
        game = HighScoreViewModel.createGame(indexOfTheme)
    }
    
    static var emojiThemes = [
        EmojiTheme(name: "Animals", emojis: ["🦉", "🦆", "🦘", "🐿", "🦔", "🐇"], color: Color.purple, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Breads", emojis: ["🥐", "🍞", "🥖", "🧇", "🥯", "🥞"], color: Color.green, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Faces", emojis: ["😀", "😉", "😇", "😡", "😜", "🥶"], color: Color.yellow, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Fruits", emojis: ["🍓", "🍐", "🍊", "🍑", "🥝", "🍍"], color: Color.orange, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Sports", emojis: ["🏀", "⚽️", "🏈", "⚾️", "🎾", "🏐"], color: Color.red, numberOfPairsOfCards: 6),
        EmojiTheme(name: "Random", emojis: [], color: Color.gray, numberOfPairsOfCards: 6)
    ]
    
    static var additonalColors = [
        Color.pink,
        Color.blue,
        Color.black,
        Color.gray
    ]
    
    private static func randomEmojiTheme() -> EmojiTheme {
        let randomIndexEmojis = Int.random(in:0...EmojiConcentrationGame.emojiThemes.count - 2)
        let randomIndexNumberOfPairs = Int.random(in:2...6)
        let randomIndexColor = Int.random(in:0...EmojiConcentrationGame.additonalColors.count - 1)
        return EmojiTheme(name: "Random", emojis: EmojiConcentrationGame.emojiThemes[randomIndexEmojis].emojis, color: EmojiConcentrationGame.additonalColors[randomIndexColor], numberOfPairsOfCards: randomIndexNumberOfPairs)
    }
    
    private static func createGame(_ indexOfTheme: Int) -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: emojiThemes[indexOfTheme].numberOfPairsOfCards) {
            index in
            emojiThemes[indexOfTheme].emojis[index]
        }
    }
    
    // MARK: - Access to model
    
    var userDefault: UserDefaults {
        game.defaults
    }
    
    // MARK: - Intents
}

