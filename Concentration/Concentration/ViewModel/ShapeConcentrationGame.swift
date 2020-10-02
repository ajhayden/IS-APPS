//
//  ShapeConcentrationGame.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

class ShapeTheme: Identifiable {
    var name: String
    var shapes: [String]
    var color: Color
    var numberOfPairsOfCards: Int
    
    init(name: String, shapes: [String], color: Color, numberOfPairsOfCards: Int) {
        self.name = name
        self.shapes = shapes
        self.color = color
        self.numberOfPairsOfCards = numberOfPairsOfCards
    }
}

class ShapeConcentrationGame: ObservableObject {
    @Published private var game: ConcentrationGame<String>
    @Published private var isVisable = false
    
    var indexOfTheme: Int
    
    init(indexOfTheme: Int = 0) {
        self.indexOfTheme = indexOfTheme
        game = ShapeConcentrationGame.createGame(indexOfTheme)
    }
    
    static var shapeThemes = [
        ShapeTheme(name: "Shapes Set 1", shapes: ["square", "circle", "badge"], color: Color.blue, numberOfPairsOfCards: 3),
        ShapeTheme(name: "Shapes Set 2", shapes: ["squiggle", "circle", "rectangle"], color: Color.red, numberOfPairsOfCards: 3)
    ]
    
    private static func createGame(_ indexOfTheme: Int) -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: shapeThemes[indexOfTheme].numberOfPairsOfCards) {
            index in
            shapeThemes[indexOfTheme].shapes[index]
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
    
    func choose(_ card: ConcentrationGame<String>.Card, gameType: String = "shape", gameTheme: String, score: String) {
        game.choose(card, gameType, gameTheme, score)
    }
    
    func dealCards() {
        isVisable = true
    }
    
    func resetCards() {
        game = ShapeConcentrationGame.createGame(indexOfTheme)
    }
    
}
