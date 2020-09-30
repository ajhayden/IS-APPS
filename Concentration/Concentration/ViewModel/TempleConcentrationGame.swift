//
//  TempleConcentrationGame.swift
//  Concentration
//
//  Created by Student on 9/28/20.
//

import SwiftUI

class TempleTheme: Identifiable {
    var name: String
    var temples: [Image]
    var color: Color
    var numberOfPairsOfCards: Int
    
    init(name: String, temples: [Image], color: Color, numberOfPairsOfCards: Int) {
        self.name = name
        self.temples = temples
        self.color = color
        self.numberOfPairsOfCards = numberOfPairsOfCards
    }
}

class TempleConcentrationGame: ObservableObject {
    @Published private var game: ConcentrationGame<Image>

    static var templeHighScore = 0
    
    var indexOfTheme: Int
    
    init(indexOfTheme: Int = 0) {
        self.indexOfTheme = indexOfTheme
        game = TempleConcentrationGame.createGame(indexOfTheme)
    }

    static var temples = [
        TempleTheme(name: "Utah Temples", temples: [Image("brigham_city_utah"), Image("cedar_city_utah"), Image("draper_utah"), Image("jordan_river_utah"), Image("logan_utah"), Image("manti_utah"), Image("oquirrh_mountain_utah"), Image("provo_city_center_utah"), Image("salt_lake_utah")], color: Color.green, numberOfPairsOfCards: 9),
        TempleTheme(name: "European Temples", temples: [Image("bern_switzerland_europe"), Image("copenhangen_denmark_europe"), Image("freiberg_germany_europe"), Image("helsinki_finland_europe"), Image("kyiv_ukraine_europe"), Image("londan_england_europe"), Image("madrid_spain_europe"), Image("paris_france_europe"), Image("rome_italy_europe")], color: Color.blue, numberOfPairsOfCards: 9),
        TempleTheme(name: "South American Temples", temples: [Image("asuncion_paraguay_sa"), Image("barranquilla_colombia_sa"), Image("buenos_aires_argentina_sa"), Image("cochabamba_chile_sa"), Image("cocepcion_chile_sa"), Image("guayaquil_ecuador_sa"), Image("lima_peru_sa"), Image("rio_de_janeiro_sa"), Image("trujillo_peru_sa")], color: Color.yellow, numberOfPairsOfCards: 9)
    ]
    
    private static func createGame(_ indexOfTheme: Int) -> ConcentrationGame<Image> {
        ConcentrationGame<Image>(numberOfPairsOfCards: temples[indexOfTheme].numberOfPairsOfCards) {
            index in
            temples[indexOfTheme].temples[index]
        }
    }
    
    // MARK: - Access to model
    
    var cards: Array<ConcentrationGame<Image>.Card> {
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
    
    func choose(_ card: ConcentrationGame<Image>.Card, gameType: String = "emoji", gameTheme: String, score: String) {
        game.choose(card, gameType, gameTheme, score)
    }
    
    func resetCards() {
        game = TempleConcentrationGame.createGame(indexOfTheme)
    }
    
    func setHighScore(gameHighScore: Int) {
//        if(EmojiConcentrationGame.emojiHighScore < gameHighScore) {
//            EmojiConcentrationGame.emojiHighScore = gameHighScore
//        }
    }
    
}

