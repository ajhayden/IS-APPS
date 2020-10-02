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
                .foregroundColor(Color.blue)
                .font(.system(size: 30))
                .padding(.bottom, 30)
            
            ForEach(shapeThemes.indices) { index in
                NavigationLink(destination: ShapeConcentrationGameView(shapeGame: ShapeConcentrationGame(indexOfTheme: index), cardColor: shapeThemes[index].color)) {
                    Text("\(shapeThemes[index].name)")
                }
                .foregroundColor(Color.white)
                .frame(width: 200, height: 50)
                .background(shapeThemes[index].color)
                .clipShape(RoundedRectangle(cornerRadius: 10))
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
