//
//  ViewModel.swift
//  Set
//
//  Created by Student on 9/24/20.
//

import Foundation

class ViewModel: ObservableObject {
    @Published private var model = Model(cards: [])
    
    // MARK: - Model access
    
    var cards: [Model.Card] {
        model.cards
    }
    
    // MARK: - Intents
    
    func dealCard() {
        model.cardCount += 1
    }
}
