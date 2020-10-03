//
//  HighScoreViewModel.swift
//  Concentration
//
//  Created by Student on 9/29/20.
//

import SwiftUI

class HighScoreViewModel: ObservableObject {
    @Published var defaults = UserDefaults.standard
    
    var userDefault: UserDefaults {
        UserDefaults.standard
    }
    
    var overallHighScore: String {
        var highScoreToAdd = 0
        
        let highScoreNameArray = ["emojiAnimalsHighScore", "emojiBreadsHighScore", "emojiFacesHighScore", "emojiFruitsHighScore", "emojiSportsHighScore", "emojiRandomHighScore", "templeUtah TemplesHighScore", "templeEuropean TemplesHighScore", "emojiSouth American TemplesHighScore", "shapeNormal", "shapeSquiggles", "basketballNBAHighScore", "basketballCollegeHighScore", "basketballThe KidsHighScore"]
        
        var scoresArray: [Int] = []
        
        for name in highScoreNameArray {
            if UserDefaults.standard.string(forKey: name) ?? "Never Played"  != "Never Played" {
                let temp = UserDefaults.standard.string(forKey: name) ?? "Never Played"
                highScoreToAdd = Int(temp)!
                scoresArray.append(highScoreToAdd)
            }
        }

        if scoresArray == [] {
            return "No High Score"
        } else {
            return String(scoresArray.max()!)
        }
        
    }
    
}



