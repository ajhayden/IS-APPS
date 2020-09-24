//
//  GameScores.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct GameScores: View {
    var body: some View {
        VStack {
            Text("High Scores")
                .bold()
                .foregroundColor(Color.black)
                .font(.system(size: 30))
                .padding()
        }
    }
}

struct GameScores_Previews: PreviewProvider {
    static var previews: some View {
        GameScores()
    }
}
