//
//  Model.swift
//  Set
//
//  Created by Student on 9/24/20.
//

import Foundation

struct Model {
    var cards: [Card]
    var cardCount: Int
    
    mutating func dealCard() {
        cards.append(Card())
    }
    
    struct Card: Identifiable {
        var id = UUID()
        var content = "A Card"
    }
}
