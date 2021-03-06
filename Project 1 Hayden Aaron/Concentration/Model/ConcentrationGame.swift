//
//  ConcentrationGame.swift
//  Concentration
//
//  Created by Steve Liddle on 9/4/20.
//

import Foundation

struct ConcentrationGame<CardContent> where CardContent: Equatable {
    private(set) var cards: Array<Card>
    
    let defaults = UserDefaults.standard
    
    var audioPlayer = SoundPlayer()
    
    private var indexOfTheOneAndOnlyOneFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }

    init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
        cards = Array<Card>()
        
        for pairIndex in 0..<numberOfPairsOfCards {
            let content = cardContentFactory(pairIndex)

            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }

        cards.shuffle()
    }
    
    var cardsMatched = 0

    mutating func choose(_ card: Card, _ gameType: String, _ gameTheme: String, _ score: String) {
//        UserDefaults.standard.register(defaults: ["soundOption": true])
        if let chosenIndex = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            
            cards[chosenIndex].viewedCount += 1
            
            if let potentialMatchIndex = indexOfTheOneAndOnlyOneFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    cardsMatched = cardsMatched + 2
                    if defaults.bool(forKey: "soundOption") == true {
                        audioPlayer.playSound(named: "success.mp3")
                    }
                } else {
                    cards[chosenIndex].markMismatched()
                    cards[potentialMatchIndex].markMismatched()
//                    if defaults.bool(forKey: "soundOption") == true {
//                        audioPlayer.playSound(named: "fail2.mp3")
//                    }
                }
                cards[chosenIndex].isFaceUp = true
            } else {
                indexOfTheOneAndOnlyOneFaceUpCard = chosenIndex
            }
        }
        
        if(cardsMatched == cards.count) {
            let possibleNewScore: Int = Int(score)! + 2
            let stringScore: String = defaults.string(forKey: "\(gameType)\(gameTheme)HighScore") ?? "Never Played"
            
            if(stringScore != "Never Played") {
                let oldScore: Int = Int(stringScore)!
                if(possibleNewScore > oldScore) {
                    defaults.set(possibleNewScore, forKey: "\(gameType)\(gameTheme)HighScore")
                }
            } else {
                defaults.set(possibleNewScore, forKey: "\(gameType)\(gameTheme)HighScore")
            }
        }
    }
    
    struct Card: Identifiable {
        private let matchScore = 5
        private let maxMathBonus = 5.0
        
        var isFaceUp = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        var isMatched = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var mismatchedCount = 0
        var viewedCount = 0
        var content: CardContent
        var id = UUID()
        
        var score: Int {
            if isMatched {
                return matchScore + Int(bonusRemaining * maxMathBonus)
            } else {
                return 0
            }
        }
        
        mutating func markMismatched() {
            if viewedCount > 1 {
                mismatchedCount += 1
            }
        }
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 12
        var lastFaceUpTime: Date?
        var pastFaceUpTime: TimeInterval = 0
        
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        
        var hasEarnedBonus: Bool {
            isMatched && bonusTimeRemaining > 0
        }
        
        var isConsumingBonusTime: Bool {
            isFaceUp && !isMatched && bonusTimeRemaining > 0
        }
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpTime = lastFaceUpTime {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpTime)
            } else {
                return pastFaceUpTime
            }
        }
        
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime && lastFaceUpTime == nil {
                lastFaceUpTime = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            lastFaceUpTime = nil
        }
    }
}
