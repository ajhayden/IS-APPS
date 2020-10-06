//
//  ShapeConcentrationGame.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

class ShapeTheme: Identifiable {
    private(set) var name: String
    private(set) var shapes: [String]
    private(set) var color: Color
    private(set) var numberOfPairsOfCards: Int
    
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
    
    private(set) var indexOfTheme: Int
    
    init(indexOfTheme: Int = 0) {
        self.indexOfTheme = indexOfTheme
        game = ShapeConcentrationGame.createGame(indexOfTheme)
    }
    
    static var shapeThemes = [
        ShapeTheme(name: "Normal", shapes: ["square", "circle", "badge", "square", "circle", "badge"], color: Color.blue, numberOfPairsOfCards: 3),
        ShapeTheme(name: "Squiggles", shapes: ["redSquiggle", "greenSquiggle", "blueSquiggle", "orangeSquiggle", "purpleSquiggle", "pinkSquiggle"], color: Color.red, numberOfPairsOfCards: 6)
    ]
    
    private static func createGame(_ indexOfTheme: Int, overrideNumber: Int? = nil) -> ConcentrationGame<String> {
        if overrideNumber == nil {
            return ConcentrationGame<String>(numberOfPairsOfCards: shapeThemes[indexOfTheme].numberOfPairsOfCards) {
                index in
                shapeThemes[indexOfTheme].shapes[index]
            }
        } else {
            return ConcentrationGame<String>(numberOfPairsOfCards: overrideNumber!) {
                index in
                shapeThemes[indexOfTheme].shapes[index]
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
        ShapeConcentrationGame.shapeThemes[indexOfTheme].color
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
    
    func resetCardsBySettings(newNumberOfPairsOfCards: Int = 2) {
        game = ShapeConcentrationGame.createGame(indexOfTheme, overrideNumber: newNumberOfPairsOfCards)
    }
    
}
