//
//  GameScores.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct GameScores: View {
    
    @ObservedObject var highScoreViewModel: HighScoreViewModel
    
    var body: some View {
        VStack {
            Group {
                Text("Emoji Mojo Scores")
                    .bold()
                    .foregroundColor(Color.purple)
                    .font(.system(size: 20))
                    .padding()
                Text("Animals: \(highScoreViewModel.userDefault.string(forKey: "emojiAnimalsHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("Bread: \(highScoreViewModel.userDefault.string(forKey: "emojiBreadHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("Faces: \(highScoreViewModel.userDefault.string(forKey: "emojiFacesHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("Fruits: \(highScoreViewModel.userDefault.string(forKey: "emojiFruitsHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("Sports: \(highScoreViewModel.userDefault.string(forKey: "emojiSportsHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("Random: \(highScoreViewModel.userDefault.string(forKey: "emojiRandomHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
            }
            
            Group {
                Text("Temple Match")
                    .bold()
                    .foregroundColor(Color.green)
                    .font(.system(size: 20))
                    .padding()
                Text("Utah Temples: \(highScoreViewModel.userDefault.string(forKey: "emojiAnimalsHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("European Temples: \(highScoreViewModel.userDefault.string(forKey: "emojiBreadHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("South American Temples: \(highScoreViewModel.userDefault.string(forKey: "emojiFacesHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
            }
            
            Group {
                Text("Shape Scape")
                    .bold()
                    .foregroundColor(Color.blue)
                    .font(.system(size: 20))
                    .padding()
                Text("Shape Set 1: \(highScoreViewModel.userDefault.string(forKey: "emojiAnimalsHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("Shape Set 2: \(highScoreViewModel.userDefault.string(forKey: "emojiBreadHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
            }
            
            Group {
                Text("Basketball Bounce")
                    .bold()
                    .foregroundColor(Color.orange)
                    .font(.system(size: 20))
                    .padding()
                Text("NBA: \(highScoreViewModel.userDefault.string(forKey: "emojiAnimalsHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("College: \(highScoreViewModel.userDefault.string(forKey: "emojiBreadHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
                Text("Street-ball: \(highScoreViewModel.userDefault.string(forKey: "emojiBreadHighScore") ?? "Unplayed")")
                    .bold()
                    .foregroundColor(Color.black)
            }
            
            
        }
    }
}

struct GameScores_Previews: PreviewProvider {
    static var previews: some View {
        GameScores(highScoreViewModel: HighScoreViewModel())
    }
}
