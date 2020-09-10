//
//  ContentView.swift
//  Concentration
//
//  Created by Student on 9/9/20.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        HStack {
            ForEach(0..<4, content: { index in
                CardView(isFaceUp: true)
            })
        }
        .padding()
        .foregroundColor(.blue)
    }
}

struct CardView: View {
    var isFaceUp: Bool
    var body: some View {
        ZStack {
            if isFaceUp {
                RoundedRectangle(cornerRadius: 10).fill(Color.white)
                RoundedRectangle(cornerRadius: 10).stroke()
                Text("🥨")
                    .font(.largeTitle)
            } else {
                RoundedRectangle(cornerRadius: 10).fill()
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
