//
//  TempleConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/28/20.
//

import SwiftUI

class TempleTheme: Identifiable {
    var name: String
    var temples: [String]
    var color: Color
    var numberOfPairsOfCards: Int
    
    init(name: String, temples: [String], color: Color, numberOfPairsOfCards: Int) {
        self.name = name
        self.temples = temples
        self.color = color
        self.numberOfPairsOfCards = numberOfPairsOfCards
    }
}

class TempleConcentrationGame: ObservableObject {
    @Published private var game: ConcentrationGame<String>
    @Published private var isVisable = false
    
    var indexOfTheme: Int
    
    init(indexOfTheme: Int = 0) {
        self.indexOfTheme = indexOfTheme
        game = TempleConcentrationGame.createGame(indexOfTheme)
    }

    static var templeThemes = [
        TempleTheme(name: "Utah Temples", temples: ["brigham_city_utah", "cedar_city_utah", "draper_utah", "jordan_river_utah", "logan_utah", "manti_utah", "oquirrh_mountain_utah", "provo_city_center_utah", "salt_lake_utah"], color: Color.green, numberOfPairsOfCards: 9),
        TempleTheme(name: "European Temples", temples: ["bern_switzerland_europe", "copenhagen_denmark_europe", "freiberg_germany_europe", "helsinki_finland_europe", "kyiv_ukraine_europe", "london_england_europe", "madrid_spain_europe", "paris_france_europe", "rome_italy_europe"], color: Color.blue, numberOfPairsOfCards: 9),
        TempleTheme(name: "South American Temples", temples: ["asuncion_paraguay_sa", "barranquilla_colombia_sa", "buenos_aires_argentina_sa", "cochabamba_bolivia_sa", "concepcion_chile_sa", "guayaquil_ecuador_sa", "lima_peru_sa", "rio_de_janeiro_sa", "trujillo_peru_sa"], color: Color.yellow, numberOfPairsOfCards: 9)
    ]
    
    private static func createGame(_ indexOfTheme: Int) -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: templeThemes[indexOfTheme].numberOfPairsOfCards) {
            index in
            templeThemes[indexOfTheme].temples[index]
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
    
    func choose(_ card: ConcentrationGame<String>.Card, gameType: String = "temple", gameTheme: String, score: String) {
        game.choose(card, gameType, gameTheme, score)
    }
    
    func dealCards() {
        isVisable = true
    }
    
    func resetCards() {
        game = TempleConcentrationGame.createGame(indexOfTheme)
    }
    
}

