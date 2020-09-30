//
//  KeyStore.swift
//  Concentration
//
//  Created by Student on 9/29/20.
//

import Foundation
import Combine

class EmojiHighScoreStore: ObservableObject {
    @Published var emojiAnimalHighScore: Int {
        didSet {
            UserDefaults.standard.set(emojiAnimalHighScore, forKey: "emojiAnimalHighScore")
        }
    }
    
    @Published var emojiBreadHighScore: Int {
        didSet {
            UserDefaults.standard.set(emojiBreadHighScore, forKey: "emojiBreadHighScore")
        }
    }
    
    init() {
        self.emojiAnimalHighScore = UserDefaults.standard.object(forKey: "emojiAnimalHighScore") as? Int ?? 0
        self.emojiBreadHighScore = UserDefaults.standard.object(forKey: "emojiBreadHighScore") as? Int ?? 0
    }
}
