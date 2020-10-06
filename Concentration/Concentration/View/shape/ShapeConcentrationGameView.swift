//
//  ShapeConcentrationGameView.swift
//  Concentration
//
//  Created by Student on 10/1/20.
//

import SwiftUI

struct ShapeConcentrationGameView: View {
    @ObservedObject var shapeGame: ShapeConcentrationGame
    
    private func columns(for size: CGSize) -> [GridItem] {
        Array(repeating: GridItem(.flexible()), count: Int(size.width / desiredCardWidth))
    }
     
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack {
                        Text("Score: \(shapeGame.score)")
                            .bold()
                            .foregroundColor(shapeGame.cardColor)
                            .font(.system(size: 20))
                        Text("High Score: \(shapeGame.userDefault.string(forKey: "shape\(ShapeConcentrationGame.shapeThemes[shapeGame.indexOfTheme].name)HighScore") ?? "Never Played")")
                            .bold()
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                    }
                    
                    Spacer()
                    
                    VStack {
                        Button("New Game") {
                            withAnimation(.easeInOut(duration: 0.75)) {
                                shapeGame.resetCards()
                            }
                        }
                        .foregroundColor(shapeGame.cardColor)
                        .frame(width: 110, height: 45)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .font(.system(size: 19))
                        .padding(.bottom, 1)
                        
                        NavigationLink("Settings", destination: ShapeSettingsView(game: shapeGame))
                        .foregroundColor(Color.gray)
                        .frame(width: 90, height: 35)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .font(.system(size: 15))
                    }
                }
                .padding(.top, 20)
                .padding(.leading, 40)
                .padding(.trailing, 40)
                GeometryReader { geometry in
                    LazyVGrid(columns: columns(for: geometry.size) ) {
                        ForEach(shapeGame.cards) { card in
                            ShapeView(card: card)
                                .onTapGesture {
                                    withAnimation(.linear(duration: 0.5)) {
                                       shapeGame.choose(card, gameType: "shape", gameTheme: "\(ShapeConcentrationGame.shapeThemes[shapeGame.indexOfTheme].name)", score: "\(shapeGame.score)")
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
                                shapeGame.dealCards()
                            }
                        }
                    }
                    .padding(.top, 20)
                    .padding(.leading, 40)
                    .padding(.trailing, 40)
                    .foregroundColor(shapeGame.cardColor)
                }
            }
        }
    }
    

    private func randomLocationOffScreen(for size: CGSize) -> CGSize {
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

struct ShapeConcentrationGameView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeConcentrationGameView(shapeGame: ShapeConcentrationGame(indexOfTheme: 0))
    }
}
