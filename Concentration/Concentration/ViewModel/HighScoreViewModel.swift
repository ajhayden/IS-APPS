//
//  HighScoreViewModel.swift
//  Concentration
//
//  Created by Student on 9/29/20.
//

import SwiftUI

class HighScoreViewModel: ObservableObject {
    @Published private var game: ConcentrationGame<String>
    
    init() {
        game = HighScoreViewModel.createExample()
    }

    static var emojis = ["🦉"]
    static func createExample() -> ConcentrationGame<String> {
        ConcentrationGame<String>(numberOfPairsOfCards: 1) {
            index in
            emojis[index]
        }
    }
    
    // MARK: - Access to model
    
    var userDefault: UserDefaults {
        game.defaults
    }
}

