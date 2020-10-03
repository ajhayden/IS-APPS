//
//  BasketballGameOptionsView.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

struct BasketballGameOptionsView: View {
    
    var basketballThemes = BasketballConcentrationGame.basketballThemes

    var body: some View {
        VStack {
            Text("Basketball Bounce")
                .bold()
                .foregroundColor(Color.gray)
                .font(.system(size: 30))
                .padding(.bottom, 30)
            
            ForEach(basketballThemes.indices) { index in
                NavigationLink(destination: BasketballConcentrationGameView(basketballGame: BasketballConcentrationGame(indexOfTheme: index))) {
                    Text("\(basketballThemes[index].name)")
                }
                .foregroundColor(basketballThemes[index].color)
                .frame(width: 200, height: 50)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .font(.system(size: 19))
                .padding(.bottom)
            }

        }
    }
}

struct BasketballGameOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        BasketballGameOptionsView()
    }
}

