//
//  Home.swift
//  Concentration
//
//  Created by Student on 9/23/20.
//

import SwiftUI

struct MenuItem: Identifiable {
    var id = UUID()
    var name: String
    var color: Color
}

let menuItems = [
    MenuItem(name: "Emoji Mojo", color: .purple),
    MenuItem(name: "Temple Match", color: .green),
    MenuItem(name: "Shape Scape", color: .blue),
    MenuItem(name: "Basketball Bounce", color: .orange),
]

let menuItems2 = [
    MenuItem(name: "High Scores", color: .gray),
    MenuItem(name: "Settings", color: .gray)
]

@ViewBuilder
private func viewBuilder(viewType: String) -> some View {
    if viewType == "Emoji Mojo" {
        EmojiGameOptionsView()
    }
    else if viewType == "Temple Match" {
        TempleGameOptionsView()
    }
    else if viewType == "Shape Scape" {
        ShapeGameOptionsView()
    }
    else if viewType == "Basketball Bounce" {
        BasketballGameOptionsView()
    }
    else if viewType == "High Scores" {
        ScoresView(highScoreViewModel: HighScoreViewModel())
    }
    else if viewType == "Settings" {
        SettingsView()
    } else {
        EmojiGameOptionsView()
    }
}

struct Home: View {
    var body: some View {
            NavigationView {
                VStack {
                    Text("Concentration Attack")
                        .bold()
                        .foregroundColor(Color.gray)
                        .font(.system(size: 30))
                        .padding(.bottom, 30)
                    ForEach(menuItems) { item in
                        NavigationLink(item.name, destination: viewBuilder(viewType: item.name))
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .background(item.color)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .font(.system(size: 19))
                            .padding(.bottom, 15)
                    }
                    HStack {
                        ForEach(menuItems2) { item in
                            NavigationLink(item.name, destination: viewBuilder(viewType: item.name))
                                .foregroundColor(Color.white)
                                .frame(width: 95, height: 50)
                                .multilineTextAlignment(.center)
                                .background(Color.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .font(.system(size: 19))
                    }
                }
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
