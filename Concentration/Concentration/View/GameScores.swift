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
            Text("\(highScoreViewModel.userDefault.string(forKey: "emojiAnimalsHighScore") ?? "Unplayed")")
                .bold()
                .foregroundColor(Color.black)
                .font(.system(size: 30))
                .padding()
            Text("\(highScoreViewModel.userDefault.string(forKey: "emojiSportsHighScore") ?? "Unplayed")")
                .bold()
                .foregroundColor(Color.black)
                .font(.system(size: 30))
                .padding()
        }
    }
}

struct GameScores_Previews: PreviewProvider {
    static var previews: some View {
        GameScores(highScoreViewModel: HighScoreViewModel(indexOfTheme: 0))
    }
}
