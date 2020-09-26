//
//  EmojiGameOptions.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct EmojiGameOptions: View {
    
    var emojiThemes = EmojiConcentrationGame.emojis

    var body: some View {
        VStack {
            Text("Emoji Mojo")
                .bold()
                .foregroundColor(Color.purple)
                .font(.system(size: 30))
                .padding()
            
            ForEach(emojiThemes.indices) { index in
                NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(indexOfTheme: index), cardColor: emojiThemes[index].color)) {
                    Text("\(emojiThemes[index].name) and \(index)")
                }
                .foregroundColor(Color.white)
                .frame(width: 200, height: 60)
                .background(emojiThemes[index].color)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 19))
                .padding()
            }

        }
    }
}

struct EmojiGameOptions_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameOptions()
    }
}
