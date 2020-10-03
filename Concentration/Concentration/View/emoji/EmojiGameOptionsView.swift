//
//  EmojiGameOptionsView.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct EmojiGameOptionsView: View {
    
    var emojiThemes = EmojiConcentrationGame.emojiThemes
    
    var body: some View {
        VStack {
            Text("Emoji Mojo")
                .bold()
                .foregroundColor(Color.gray)
                .font(.system(size: 30))
                .padding(.bottom, 30)
            
            ForEach(emojiThemes.indices) { index in
                NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(indexOfTheme: index))) {
                    Text("\(emojiThemes[index].name)")
                }
                .foregroundColor(emojiThemes[index].color)
                .frame(width: 200, height: 50)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .font(.system(size: 19))
                .padding(.bottom)
            }
        }
    }
}

struct EmojiGameOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameOptionsView()
    }
}
