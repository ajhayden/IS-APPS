//
//  ShapeGameOptionsView.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

struct ShapeGameOptionsView: View {
    
    var shapeThemes = ShapeConcentrationGame.shapeThemes
    
    var body: some View {
        VStack {
            Text("Shape Scape")
                .bold()
                .foregroundColor(Color.gray)
                .font(.system(size: 30))
                .padding(.bottom, 30)
            
            ForEach(shapeThemes.indices) { index in
                NavigationLink(destination: ShapeConcentrationGameView(shapeGame: ShapeConcentrationGame(indexOfTheme: index))) {
                    Text("\(shapeThemes[index].name)")
                }
                .foregroundColor(shapeThemes[index].color)
                .frame(width: 200, height: 50)
                .background(Color.gray)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .font(.system(size: 19))
                .padding(.bottom)
            }
        }
    }
}

struct ShapeGameOptionsView_Previews: PreviewProvider {
    static var previews: some View {
        EmojiGameOptionsView()
    }
}
