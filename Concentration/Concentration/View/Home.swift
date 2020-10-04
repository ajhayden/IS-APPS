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
            ScrollView {
                VStack {
                    Text("Concentration Attack")
                        .bold()
                        .foregroundColor(Color.gray)
                        .font(.system(size: 30))
                        .padding(.bottom, 30)
                    ForEach(menuItems) { item in
                        NavigationLink(item.name, destination: viewBuilder(viewType: item.name))
                            .foregroundColor(item.color)
                            .frame(width: 200, height: 50)
                            .background(Color.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .font(.system(size: 20))
                            .padding(.bottom, 13)
                    }
                    HStack {
                        ForEach(menuItems2) { item in
                            NavigationLink(item.name, destination: viewBuilder(viewType: item.name))
                                .foregroundColor(Color.gray)
                                .frame(width: 95, height: 50)
                                .multilineTextAlignment(.center)
                                .background(Color.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .font(.system(size: 13))
                        }
                    }
                    .onAppear {
                        registerSoundToTrue()
                    }
                }   
            }
        }
    }
}

func registerSoundToTrue() {
    UserDefaults.standard.register(defaults: ["soundOption" : true])
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
