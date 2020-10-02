//
//  BasketballConcentrationGame.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

class BasketballTheme: Identifiable {
    var name: String
    var players: [String]
    var color: Color
    var numberOfPairsOfCards: Int
    
    init(name: String, players: [String], color: Color, numberOfPairsOfCards: Int) {
        self.name = name
        self.players = players
        self.color = color
        self.numberOfPairsOfCards = numberOfPairsOfCards
    }
}

class BasketballConcentrationGame: ObservableObject {
    @Published private var game: ConcentrationGame<String>
    @Published private var isVisable = false
    
    var indexOfTheme: Int
    
    init(indexOfTheme: Int = 0) {
        self.indexOfTheme = indexOfTheme
        game = BasketballConcentrationGame.createGame(indexOfTheme)
    }

    static var basketballThemes = [
        BasketballTheme(name: "NBA", players: ["lebron_nba", "durant_nba", "leonard_nba", "curry_nba", "mitchell_nba", "kobe_nba"], color: Color.orange, numberOfPairsOfCards: 6),
        BasketballTheme(name: "College", players: ["lebron_college", "durant_college", "leonard_college", "curry_college", "mitchell_college", "kobe_college"], color: Color.yellow, numberOfPairsOfCards: 6),
        BasketballTheme(name: "The Kids", players: ["lebron_kid", "durant_kid", "leonard_kid", "curry_kid", "mitchell_kid", "kobe_kid"], color: Color.red, numberOfPairsOfCards: 6)
    ]
    
    private static func createGame(_ indexOfTheme: Int) -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: basketballThemes[indexOfTheme].numberOfPairsOfCards) {
            index in
            basketballThemes[indexOfTheme].players[index]
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
    
    var userDefault: UserDefaults {
        game.defaults
    }
    
    // MARK: - Intents
    
    func choose(_ card: ConcentrationGame<String>.Card, gameType: String = "basketball", gameTheme: String, score: String) {
        game.choose(card, gameType, gameTheme, score)
    }
    
    func dealCards() {
        isVisable = true
    }
    
    func resetCards() {
        game = BasketballConcentrationGame.createGame(indexOfTheme)
    }
    
}


