//
//  TempleSettingsView.swift
//  Concentration
//
//  Created by Student on 10/2/20.
//

import SwiftUI

struct TempleSettingsView: View {
    var game: TempleConcentrationGame
    @State private var current_num: Double = 1.0
    var body: some View {
        VStack {
            NavigationView {
                    Form {
                        Section(header: Text("Game Settings")) {
                            Slider(value: $current_num, in: 1...9, step: 1)
                            Text("Pairs of Cards: \(Int(current_num))")
                            Button("Save") {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    game.resetCardsBySettings(newNumberOfPairsOfCards: Int(current_num))
                                }
                            }
                            .foregroundColor(Color.white)
                            .frame(width: 90, height: 40)
                            .background(Color.green)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.system(size: 19))
                            .padding(10)
                            .padding(.trailing, 100)
                        }
                    }
                    .navigationBarTitle("Settings")
                }
        }
    }
}

struct TempleSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        TempleSettingsView(game: TempleConcentrationGame(indexOfTheme: 0))
    }
}

