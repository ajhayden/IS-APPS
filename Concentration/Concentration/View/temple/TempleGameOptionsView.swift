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
                .foregroundColor(Color.green)
                .font(.system(size: 30))
                .padding(.bottom, 30)
            
            ForEach(templeThemes.indices) { index in
                NavigationLink(destination: TempleConcentrationGameView(templeGame: TempleConcentrationGame(indexOfTheme: index), cardColor: templeThemes[index].color)) {
                    Text("\(templeThemes[index].name)")
                }
                .foregroundColor(Color.white)
                .frame(width: 200, height: 50)
                .background(templeThemes[index].color)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .font(.system(size: 19))
                .padding(.bottom)
            }

        }
    }
}

struct TempleGameOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        TempleGameOptionsView()
    }
}

