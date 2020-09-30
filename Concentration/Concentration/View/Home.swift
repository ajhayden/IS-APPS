//
//  Home.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Concentration Games")
                    .bold()
                    .foregroundColor(Color.blue)
                    .font(.system(size: 30))
                    .padding()
                NavigationLink(destination: EmojiGameOptionsView()) {
                    Text("Emoji Mojo")
                }
                .foregroundColor(Color.white)
                .frame(width: 200, height: 60)
                .background(Color.purple)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 19))
                .padding()

                NavigationLink(destination: TempleGameOptionsView()) {
                    Text("Temple Match")
                }
                .foregroundColor(Color.white)
                .frame(width: 200, height: 60)
                .background(Color.green)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 19))
                .padding()
                
                NavigationLink(destination: EmojiGameOptionsView()) {
                    Text("Shape Scape")
                }
                .foregroundColor(Color.white)
                .frame(width: 200, height: 60)
                .background(Color.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 19))
                .padding()
                
                NavigationLink(destination: EmojiGameOptionsView()) {
                    Text("Basketball Bounce")
                }
                .foregroundColor(Color.white)
                .frame(width: 200, height: 60)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 19))
                .padding()
                
                NavigationLink(destination: GameScores(highScoreViewModel: HighScoreViewModel())) {
                    Text("High Scores")
                }
                .foregroundColor(Color.white)
                .frame(width: 150, height: 60)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 19))
                .padding()
            }
        }
    }
        
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
