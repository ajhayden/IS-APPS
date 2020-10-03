//
//  TempleGameOptionsView.swift
//  Concentration
//
//  Created by Student on 9/28/20.
//

import SwiftUI

struct TempleGameOptionsView: View {
    
    var templeThemes = TempleConcentrationGame.templeThemes

    var body: some View {
        VStack {
            Text("Temple Match")
                .bold()
                .foregroundColor(Color.gray)
                .font(.system(size: 30))
                .padding(.bottom, 30)
            
            ForEach(templeThemes.indices) { index in
                NavigationLink(destination: TempleConcentrationGameView(templeGame: TempleConcentrationGame(indexOfTheme: index))) {
                    Text("\(templeThemes[index].name)")
                }
                .foregroundColor(templeThemes[index].color)
                .frame(width: 200, height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .font(.system(size: 19))
                .padding(.bottom)
                .multilineTextAlignment(.center)
            }

        }
    }
}

struct TempleGameOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        TempleGameOptionsView()
    }
}

