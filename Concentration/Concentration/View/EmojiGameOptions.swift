//
//  EmojiGameOptions.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct EmojiGameOptions: View {
    var body: some View {
        VStack {
            Text("Emoji Mojo")
                .bold()
                .foregroundColor(Color.purple)
                .font(.system(size: 30))
                .padding()
            
            NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(), cardColor: Color.purple)) {
                Text("Animals")
            }
            .foregroundColor(Color.white)
            .frame(width: 200, height: 60)
            .background(Color.purple)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.system(size: 19))
            .padding()

            NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(), cardColor: Color.green)) {
                Text("Breads")
            }
            .foregroundColor(Color.white)
            .frame(width: 200, height: 60)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.system(size: 19))
            .padding()
            
            NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(), cardColor: Color.yellow)) {
                Text("Faces")
            }
            .foregroundColor(Color.white)
            .frame(width: 200, height: 60)
            .background(Color.yellow)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.system(size: 19))
            .padding()
            
            NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(), cardColor: Color.orange)) {
                Text("Fruits")
            }
            .foregroundColor(Color.white)
            .frame(width: 200, height: 60)
            .background(Color.orange)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.system(size: 19))
            .padding()
            
            NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(), cardColor: Color.red)) {
                Text("Halloween")
            }
            .foregroundColor(Color.white)
            .frame(width: 200, height: 60)
            .background(Color.red)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.system(size: 19))
            .padding()
            
            NavigationLink(destination: EmojiConcentrationGameView(emojiGame: EmojiConcentrationGame(), cardColor: Color.blue)) {
                Text("Random")
            }
            .foregroundColor(Color.white)
            .frame(width: 200, height: 60)
            .background(Color.blue)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .font(.system(size: 19))
            .padding()
        }
    }
}

struct EmojiGameOptions_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameOptions()
    }
}
