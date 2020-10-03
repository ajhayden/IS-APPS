//
//  TempleConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 9/28/20.
//

import SwiftUI

struct TempleConcentrationGameView: View {
    @ObservedObject var templeGame: TempleConcentrationGame
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("Score: \(templeGame.score)")
                            .bold()
                            .foregroundColor(templeGame.cardColor)
                            .font(.system(size: 20))
                        Text("High Score: \(templeGame.userDefault.string(forKey: "temple\(TempleConcentrationGame.templeThemes[templeGame.indexOfTheme].name)HighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                    }
                    Spacer()
                    
                    VStack {
                        Button("New Game") {
                            withAnimation(.easeInOut(duration: 0.75)) {
                                templeGame.resetCards()
                            }
                        }
                        .foregroundColor(templeGame.cardColor)
                        .frame(width: 110, height: 45)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.system(size: 19))
                        .padding(.bottom, 1)
                        
                        NavigationLink("Settings", destination: TempleSettingsView(game: templeGame))
                            .foregroundColor(Color.gray)
                        .frame(width: 90, height: 35)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.system(size: 15))
                    }
                }
                .padding(.top, 10)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                GeometryReader { geometry in
                    LazyVGrid(columns: columns(for: geometry.size) ) {
                        ForEach(templeGame.cards) { card in
                            TempleCardView(card: card)
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                        templeGame.choose(card, gameType: "temple", gameTheme: "\(TempleConcentrationGame.templeThemes[templeGame.indexOfTheme].name)", score: "\(templeGame.score)")
                                    }
                                }
                                .transition(AnyTransition.offset(
                                    randomLocationOffScreen(for: geometry.size)
                                ))
                        }
                    }
                    .onAppear() {
                        DispatchQueue.main.async {
                            withAnimation(Animation.easeInOut(duration: 1.5)) {
                                templeGame.dealCards()
                            }
                        }
                    }
                    .padding(.top, 0)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .padding(.bottom, 0)
                    .foregroundColor(templeGame.cardColor)
                }
            }
        }
    }
    

    func randomLocationOffScreen(for size: CGSize) -> CGSize {
        var randomSize = CGSize.zero
        let randomAngle = Double.random(in: 0..<Double.pi * 2)
        let scaleFactor = max(size.width, size.height) * 1.5
        
        randomSize.width = CGFloat(sin(randomAngle)) * scaleFactor
        randomSize.height = CGFloat(cos(randomAngle)) * scaleFactor
        
        return randomSize
    }
    
    //MARK: - Drawing constants
    
    private let desiredCardWidth: CGFloat = 100
}

struct TempleConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        TempleConcentrationGameView(templeGame: TempleConcentrationGame(indexOfTheme: 0))
    }
}
